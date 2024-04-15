
" ----- puremourning/vimspector ----- {{{
"let g:vimspector_install_gadgets = ['CodeLLDB']
"
"nmap <leader>gc <Plug>VimspectorContinue
"nmap <leader>gq <Plug>VimspectorStop
"nmap <leader>gr         <Plug>VimspectorRestart
"nmap <leader>gp         <Plug>VimspectorPause
"nmap <leader>gb <Plug>VimspectorToggleBreakpoint
"nmap <leader>gm <Plug>VimspectorAddFunctionBreakpoint
"nmap <leader>gn <Plug>VimspectorStepOver
"nmap <leader>gs <Plug>VimspectorStepInto
"nmap <leader>gf <Plug>VimspectorStepOut
"" gi is now go to implementation
"" nmap <leader>gi <Plug>VimspectorBalloonEval
"nnoremap <leader>ge :VimspectorEval<space>
"nnoremap <leader>gx :VimspectorEval -exec<space>
"nnoremap <leader>gw :VimspectorWatch<CR>
"nnoremap <leader>gz :VimspectorReset<CR>
"nnoremap <leader>go :call feedkeys(":VimspectorShowOutput \<Tab>", 'tn')<CR>
"" " These are some unmapped mappings
"" nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
"" nmap <leader><F8> <Plug>VimspectorRunToCursor
"
"sign define vimspectorBP         text=\ ● texthl=LCHighlightedError
"sign define vimspectorBPCond     text=\ ◆ texthl=LCHighlightedError
"sign define vimspectorBPDisabled text=\ ● texthl=LCHighlightedInfo
"sign define vimspectorPC         text=\ ▶ texthl=LCHighlightedWarn linehl=CursorLine
"sign define vimspectorPCBP       text=●▶  texthl=LCHighlightedWarn linehl=CursorLine
"" sign vimspectorCurrentThread text=▶  texthl=MatchParen linehl=CursorLine
"
"let g:vimspector_sidebar_width = 80
"
"" works but looks bad
"au User VimspectorUICreated call nvim_win_close(g:vimspector_session_windows.watches, v:false)

" }}}

" ----- mfussenegger/nvim-dap ----- {{{
" lua require('dap').adapters.lldb = {
"       \ type = 'executable',
"       \ command = '/opt/homebrew/opt/llvm@12/bin/lldb-vscode',
"       \ name = 'lldb'
"       \ }

" lua require('dap').configurations.cpp = {
"       \   {
"       \     name = 'Launch Sorbet',
"       \     type = 'lldb',
"       \     request = 'launch',
"       \     program = 'bazel-bin/main/sorbet',
"       \     args = function()
"       \       return {vim.fn.input('Ruby file: ', '', 'file'),}
"       \     end,
"       \     cwd = '${workspaceFolder}',
"       \     stopOnEntry = false,
"       \     sourceMap = function()
"       \       return {
"       \         {vim.fn.resolve('bazel-sorbet'), '${workspaceFolder}',},
"       \       }
"       \     end,
"       \   },
"       \ }

" nnoremap <leader>gc :lua require('dap').continue()<CR>
" nnoremap <leader>gq :lua require('dap').disconnect()<CR>
" nnoremap <leader>gr :lua require('dap').restart()<CR>
" nnoremap <leader>gp :lua require('dap').pause()<CR>
" nnoremap <leader>gb :lua require('dap').toggle_breakpoint()<CR>
" " nnoremap <leader>gm <Plug>VimspectorAddFunctionBreakpoint
" nnoremap <leader>gn :lua require('dap').step_over()<CR>
" nnoremap <leader>gs :lua require('dap').step_into()<CR>
" nnoremap <leader>gf :lua require('dap').step_out()<CR>
" " gi is now go to implementation
" nnoremap <leader>gi :lua require('dap.ui.widgets').hover()<CR>
" " nnoremap <leader>ge :VimspectorEval<space>
" " nnoremap <leader>gx :VimspectorEval -exec<space>
" " nnoremap <leader>gw :VimspectorWatch<CR>
" " nnoremap <leader>gz :VimspectorReset<CR>
" " nnoremap <leader>go :call feedkeys(":VimspectorShowOutput \<Tab>", 'tn')<CR>
" " " These are some unmapped mappings
" " nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
" " nmap <leader><F8> <Plug>VimspectorRunToCursor

" sign define DapBreakpoint         text=\ ● texthl=LCHighlightedError
" sign define DapBreakpointCondition     text=\ ◆ texthl=LCHighlightedError
" sign define DapStopped         text=\ ▶ texthl=LCHighlightedWarn linehl=CursorLine
" }}}
