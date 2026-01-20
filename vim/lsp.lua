-- Helpers ---------------------------------------------------------------- {{{

-- Get source from related information for a line
local function getlines(location)
	local uri = location.targetUri or location.uri
	if uri == nil then
		return
	end
	local bufnr = vim.uri_to_bufnr(uri)
	if not vim.api.nvim_buf_is_loaded(bufnr) then
		vim.fn.bufload(bufnr)
	end
	local range = location.targetRange or location.range

	local lines = vim.api.nvim_buf_get_lines(bufnr, range.start.line, range["end"].line + 1, false)
	return table.concat(lines, "\n")
end

-- }}}
-- Defaults --------------------------------------------------------------- {{{

vim.lsp.config("*", {})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil

		vim.bo[ev.buf].tagfunc = nil
		vim.bo[ev.buf].formatexpr = nil
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function(args)
		vim.diagnostic.setqflist({ open = false })
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "ℹ",
			[vim.diagnostic.severity.HINT] = "➤",
		},
	},
	-- https://github.com/neovim/neovim/issues/19649#issuecomment-1327287313
	-- Can probably delete in Neovim 0.12?
	-- https://github.com/neovim/neovim/commit/2031287e93295949fbe5349413668eb14c9546f0
	float = {
		header = "",
		scope = "cursor",
		format = function(diag)
			local message = diag.message
			local client = vim.lsp.get_clients({ name = message.source })[1]
			if not client then
				return diag.message
			end

			local relatedInfo = { messages = {}, locations = {} }
			for _, info in ipairs(diag.user_data.lsp.relatedInformation) do
				table.insert(relatedInfo.messages, info.message)
				table.insert(relatedInfo.locations, info.location)
			end

			for i, loc in ipairs(vim.lsp.util.locations_to_items(relatedInfo.locations, client.offset_encoding)) do
				if i == 1 then
					message = message .. "\n"
				end

				message = string.format(
					"%s\n%s:%d: %s\n\t%s",
					message,
					vim.fn.fnamemodify(loc.filename, ":."),
					loc.lnum,
					relatedInfo.messages[i],
					getlines(relatedInfo.locations[i])
				)
			end

			return message
		end,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "ruby", "rust", "c", "cpp" },
	callback = function()
		local opts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>t", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>ir", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ic", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "K", vim.diagnostic.open_float, opts)
	end,
})

-- }}}
-- Rust ------------------------------------------------------------------- {{{

vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
})

-- }}}
-- C/C++ ------------------------------------------------------------------ {{{

-- TODO(jez) Get this back to using the bazel clangd, not the system one
local clangd_cmd
if vim.fn.filereadable("build/compile_commands.json") == 1 then
	clangd_cmd = { "clangd", "--compile-commands-dir=build", "--background-index" }
else
	clangd_cmd = { "clangd" }
end

vim.lsp.config("clangd", {
	cmd = clangd_cmd,
	filetypes = { "c", "cpp" },
})

-- }}}
-- Harper (markdown, pandoc) ---------------------------------------------- {{{
-- vim.lsp.set_log_level("trace")
-- vim.lsp.config("harper", {
--   cmd = { "harper-ls", "--stdio" },
--   filetypes = { "pandoc" },
--   root_markers = { ".harper-dictionary.txt", ".git" },
-- })
-- }}}
-- Ruby ------------------------------------------------------------------- {{{

local sorbet_cmd = { "sorbet", "--lsp", "--debug-log-file=/tmp/sorbet-nvim.log" }
if vim.fn.filereadable("sorbet/config") == 0 then
	local script_dir = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>:p")), ":h")
	table.insert(sorbet_cmd, "-e")
	table.insert(sorbet_cmd, "0")
	table.insert(sorbet_cmd, vim.fn.fnamemodify(script_dir, ":p") .. ".empty")
end

if not (vim.fn.fnamemodify(vim.fn.getcwd(), ":p") == vim.env.HOME .. "/stripe/pay-server") then
	vim.lsp.config("sorbet", {
		cmd = sorbet_cmd,
		filetype = "ruby",
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "SorbetHierarchyReferences", function()
				local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
				params["context"] = {
					includeDeclaration = true,
				}
				client:request("sorbet/hierarchyReferences", params, function(err, res)
					if err or not res or (#res == 0) then
						return
					end

					local items = vim.lsp.util.locations_to_items(res, client.offset_encoding)
					vim.fn.setloclist(0, items)
					vim.cmd.lopen()
				end, bufnr)
			end, {})
		end,
	})
end

-- }}}

-- Enable everything ------------------------------------------------------
-- vim.lsp.enable({ "rust-analyzer", "clangd", "sorbet", "harper" })
vim.lsp.enable({ "rust-analyzer", "clangd", "sorbet" })

-- vim:fdm=marker
