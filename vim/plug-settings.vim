"
" File:       .vimrc
" Author:     Jake Zimmerman <jake@zimmerman.io>
" Modified:   2015 Feb 10
"
" Adapted from Bram Moolenaar's example vimrc.
"
" This vimrc heavily favors Solarized colors. If you don't have your terminal
" configured to use these colors, you should head over to
"
"     http://ethanschoonover.com/solarized
"
" and grab a color theme for your terminal (like iTerm2 or Terminal.app). If
" your terminal doesn't support theming, you'll want to manually change the
" appropriate colors.
"
" INSTALLATION INSTRUCTIONS
"
" Presumably, you've gotten your hands on this file because you forked my
" dotfiles repository. I keep all my Vim plugins as submodules, so after you
" clone you'll have to run
"
"     $ git submodule init
"     $ git submodule update
"
" to grab the required dependencies. Once you've done this, you can either
" manually move the `vimrc` file to `~/.vimrc` and the `vim/` folder to
" `~/.vim`, or you can be a little smarter and use a tool like rcm
" (https://github.com/thoughtbot/rcm) to manage this process.
"
" ISSUES
"
" If you encounter an issue while using this vimrc, please leave a *detailed*
" description of the issue and what'd you expect to happen in the issue
" tracker:
"
"     https://github.com/jez/dotfiles/issues
"
" CONTRIBUTING
"
" These are my personal configuration files, so I might be a little hesitant
" to accept pull requests. If you've fixed a bug though, go ahead and I'll
" take a look at it.

scriptencoding utf-8

let s:script_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" ----- Pathogen and Plugin Settings ----------------------------------------

" Pathogen is in a non-standard location: modify the rtp to reflect that
set runtimepath+=~/.vim/bundle/pathogen

" Let Pathogen take over the runtimepath to make plugins in ~/.vim/bundle work
execute pathogen#infect()

" Generate all helptags on startup
Helptags

" ----- bling/vim-airline settings ----- {{{
" Fancy arrow symbols, requires a patched font
let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Don't take up extra space with +/-/~ of 0
let g:airline#extensions#hunks#non_zero_only = 1
" Limit wordcount to where it makes sense
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|pandoc|rst|org'
" Always show statusbar
set laststatus=2
" Slightly modify the theme colors
let g:airline_solarized_normal_green = 1
" Fancy stuff in tabline as well
let g:airline#extensions#tabline#enabled = 1
" Don't try to re-init tmuxline every time (I've made special modifications)
let g:airline#extensions#tmuxline#enabled = 0
" Don't use tagbar
let g:airline#extensions#tagbar#enabled = 0
" Don't show line percentage
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ' %3v'])

" }}}
" ----- Raimondi/delimitMate settings ----- {{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_excluded_regions = ''
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType pandoc let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType eruby let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType coffee let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" }}}
" ----- alvan/vim-closetag ----- {{{
let g:closetag_filenames = '*.html,*.jsx,*.md,*.markdown,*.erb'
let g:closetag_close_shortcut = ''

"  }}}
" ----- neomake/neomake ----- {{{
let g:neomake_error_sign = {
    \ 'text': '✘',
    \ 'texthl': 'Error',
    \ }
let g:neomake_warning_sign = {
    \ 'text': '▲',
    \ 'texthl': 'Todo',
    \ }

let g:neomake_open_list = 0

" Use neomake only as a dependency for other plugins. Otherwise, prefer ALE.
let g:ale_emit_conflict_warnings = 0

" }}}
" ----- w0rp/ale ----- {{{
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'

let g:airline#extensions#ale#enabled = 1

" Open the loclist if there were errors
let g:ale_open_list = 1

" Only lint on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0

nnoremap <leader>et :ALEToggle<CR>
nnoremap <leader>ef :ALEFix<CR>

let g:ale_linters = {}
let g:ale_linters.tex = []
" We're using intero-neovim + Neomake for Haskell errors
let g:ale_linters.haskell = ['hlint']
" For stripe: use 'erubis' instead of 'erubylint'
let g:ale_linters.eruby = ['erubis']
" Use language server for Flow to try things out
let g:ale_linters.javascript = ['eslint', 'flow-language-server']
" CSS warnings were mostly chunderous
let g:ale_linters.css = []
" Using LanguageClient-neovim for Rust
let g:ale_linters.rust = []

let g:ale_linters.ruby = ['ruby']
if fnamemodify(getcwd(), ':p') =~# $HOME.'/stripe/pay-server'
  " Only use rubocop in pay-server (many rules don't make sense elsewhere)
  let g:ale_linters.ruby += ['rubocop']
  let g:ale_ruby_rubocop_executable = 'scripts/bin/rubocop-daemon/rubocop'
endif

" Be sure to never install 'prettier' globally, or you will be running
" prettier on all JavaScript files everywhere.
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier', 'eslint']
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.pandoc = ['prettier']
let g:ale_fixers.markdown = ['prettier']
let g:ale_fixers.reason = ['refmt']
let g:ale_fixers.scala = ['scalafmt']
let g:ale_fixers.rust = ['rustfmt']
let g:ale_fixers.haskell = ['brittany', 'stylish-haskell']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_rust_cargo_check_all_targets = 0

" Don't cd into folder first for shellcheck
let g:ale_sh_shellcheck_cd_buffer = 0

augroup aleMaps
  au FileType javascript let g:ale_fix_on_save = 1
  au FileType css let g:ale_fix_on_save = 1
  au FileType pandoc let g:ale_fix_on_save = 1
  au FileType markdown let g:ale_fix_on_save = 1
  au FileType reason let g:ale_fix_on_save = 1
  au FileType scala let g:ale_fix_on_save = 1
  au FileType rust let g:ale_fix_on_save = 1
  au FileType haskell let g:ale_fix_on_save = 1

  au FileType javascript nnoremap <silent> <buffer> <leader>t :ALEHover<CR>
augroup END

" ----- Folder-specific settings -----
if filereadable("./.clang-format")
  let g:ale_linters.c = []
  let g:ale_linters.cpp = []

  " Sorbet wants clang-format to put the #include for a *.h file with the same
  " name as the current *.cpp / *.cc file at the top of the #include list
  let g:ale_c_clangformat_options = '-style=file -assume-filename=%s'
  let g:ale_fixers.c = ['clang-format']
  let g:ale_fixers.cpp = ['clang-format']

  augroup aleSorbetMaps
    au FileType c let g:ale_fix_on_save = 1
    au FileType cpp let g:ale_fix_on_save = 1
  augroup END
endif

if filereadable("./compile_commands.json")
  let g:ale_linters.c = []
  let g:ale_linters.cpp = []
endif

if filereadable("build/compile_commands.json")
  let g:ale_linters.c = []
  let g:ale_linters.cpp = []
endif

" }}}
" ----- altercation/vim-colors-solarized settings ----- {{{
if $SOLARIZED ==? 'dark'
  set background=dark
elseif $SOLARIZED ==? 'light'
  set background=light
else
  set background=dark
endif

" Set the colorscheme
colorscheme solarized

" Make splits look more like tmux, with thin chars
" (Has to be after solarized to take effect)
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE
" }}}
" ----- airblade/vim-gitgutter settings ----- {{{
hi clear SignColumn

nnoremap <leader>ht :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>hm :let g:gitgutter_diff_base = 'master'<CR>:e<CR>
nnoremap <leader>r  :GitGutterUndoHunk<CR>
nnoremap <leader>s  :GitGutterStageHunk<CR>

" overrides these bindings from vanilla Vim
nnoremap gp :GitGutterPrevHunk<CR>
nnoremap gn :GitGutterNextHunk<CR>

" Update signs faster. Proceed at own risk (might be expensive for you).
set updatetime=500

" I have a patched Solarized plugin that sets these groups up
hi! link GitGutterAdd    gitgutterAdd
hi! link GitGutterChange gitgutterChange
hi! link GitGutterDelete gitgutterDelete

" }}}
" ----- tpope/vim-rhubarb settings ----- {{{

let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" }}}
" ----- pangloss/vim-javascript ----- {{{
let g:javascript_plugin_flow = 1
" }}}
" ----- mxw/vim-jsx ----- {{{
" Syntax highlighting for JSX
let g:jsx_ext_required = 0

" }}}
" ----- flowtype/vim-flow ----- {{{
" Only use Flow for type information and jump to def
let g:flow#enable = 0
let g:flow#omnifunc = 0

augroup flowMaps
  " Flow has an extra "expand aliases" setting that's not exposed through LSP
  au FileType javascript nnoremap <silent> <buffer> <leader>T :FlowTypeExpandAliases<CR>
  " Standalone jump to def works better than the LSP one w.r.t. imports
  au FileType javascript nnoremap <silent> <buffer> gd :FlowJumpToDef<CR>
augroup END

" }}}
" ----- ntpeters/vim-better-whitespace ----- {{{
" Don't highlight whitespace in git commit messages (for diffs)...
let g:better_whitespace_filetypes_blacklist=['gitcommit']
" ... but strip it on save so that we're still safe
augroup vimBetterWhiteSpace
  autocmd FileType gitcommit autocmd BufWritePre <buffer> StripWhitespace
augroup END

" Use Solarized colors for highlighting
highlight Extrawhitespace ctermbg=red guibg=#dc322f

" }}}
" ----- vim-pandoc/vim-pandoc ----- {{{
let g:pandoc#modules#disabled = ['folding', 'chdir']
let g:pandoc#syntax#codeblocks#embeds#langs = ['ruby', 'bash=zsh', 'hs=haskell']
let g:pandoc#syntax#conceal#blacklist = ['image', 'atx', 'codeblock_delim']
let g:pandoc#formatting#mode = 'h'

augroup pandocSettings
  au!

  " Auto-populate next line with things like blockquotes '>'
  au FileType pandoc setlocal formatoptions+=c

  " Indent and de-indent with TAB and SHIFT + TAB
  au FileType pandoc nnoremap <buffer> <TAB> >>
  au FileType pandoc nnoremap <buffer> <S-TAB> <<
  au FileType pandoc inoremap <buffer> <TAB> <C-t>
  au FileType pandoc inoremap <buffer> <S-TAB> <C-d>
augroup END

" }}}
" ----- vim-pandoc/vim-pandoc-syntax ----- {{{
let g:pandoc#syntax#use_definition_lists = 0
" }}}
" ----- mhinz/grepper ----- {{{
let g:grepper = {}
" Only use rg for grepping
let g:grepper.tools = ['rg']
" See ~/.vim/after for more grepper settings
" Highlight search matches (like it were hlsearch)
let g:grepper.highlight = 1
" Don't use the quickfix list. In Neovim 0.4.2, this causes grepper to get
" into a weird state. Repro:
" vim -p foo bar
" :Grepper foo<CR>
" gr
" :Grepper foo<CR>
" Observe that the screen is now irrecoverably half height
let g:grepper.quickfix = 0
" Defalt to searching the entire repo; otherwise, search 'filecwd' (see help)
" let g:grepper.dir = 'repo,filecwd'
let g:grepper.dir = 'filecwd'

" Launch grepper with operator support
nmap s <plug>(GrepperOperator)
xmap s <plug>(GrepperOperator)

nnoremap <leader>a :Grepper<CR>
nnoremap <leader>* :Grepper -cword -noprompt<CR>

" }}}
" ----- romainl/vim-qf ----- {{{
" Because grepper no longer has keybindings in the Quickfix window
let g:qf_mapping_ack_style = 1
" }}}
" ----- neovimhaskell/haskell-vim ----- {{{
let g:haskell_indent_case_alternative = 1
let g:haskell_indent_in = 0
let g:haskell_indent_let_no_in = 0
let g:haskell_indent_if = 2
let g:haskell_indent_before_where = 2
let g:haskell_classic_highlighting = 1
" }}}
" ----- sbdchd/neoformat ----- {{{
let g:neoformat_enabled_haskell = ['brittany', 'stylishhaskell']
let g:neoformat_enabled_bzl = ['buildifier']
augroup neoformatMaps
  au!
  " https://github.com/sbdchd/neoformat/issues/134
  au BufWritePre *.hs try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | silent Neoformat | endtry
  au BufWritePre *BUILD try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | silent Neoformat | endtry
  au BufWritePre *.bzl try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | silent Neoformat | endtry

  au FileType haskell let g:neoformat_run_all_formatters = 1
augroup END
" }}}
" ----- parsonsmatt/intero-neovim ----- {{{
let g:intero_start_immediately = 0
let g:intero_use_neomake = 1

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <buffer> <leader>io :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <buffer> <leader>ih :InteroHide<CR>
  " au FileType haskell nnoremap <silent> <buffer> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <buffer> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <buffer> <leader>ir :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <buffer> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <buffer> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <silent> <buffer> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <buffer> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <buffer> <leader>it :InteroTypeInsert<CR>
  " like :InteroInfo, but without echo'ing the message
  au FileType haskell noremap <silent> <buffer> <leader>ii :InteroSend<SPACE>:info<SPACE><C-R><C-W><CR>
  au FileType haskell noremap <silent> <buffer> <leader>in :InteroSend<SPACE>:kind<SPACE><C-R><C-W><CR>

  au FileType haskell nnoremap <silent> <buffer> gd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <buffer> <leader>iu :InteroUses<CR>
  " au FileType haskell nnoremap <silent> <buffer> <leader>ist :InteroSetTargets<SPACE>

  " Yank the 'i' register so that we don't conflict with the unnamed register
  au FileType haskell noremap <silent> <buffer> <leader>is "iy:InteroSend<SPACE><C-R>i<CR>

  au FileType haskell noremap <silent> <buffer> <leader>ic :InteroSend<SPACE>:!clear<CR>
  " Turn warnings off
  au FileType haskell noremap <silent> <buffer> <leader>iw :InteroSend<SPACE>:set -w<CR>
  " Turn warnings on
  au FileType haskell noremap <silent> <buffer> <leader>iW :InteroSend<SPACE>:set -Wall<CR>

  " hoogle bindings (stack install hoogle && hoogle generate)

  " Query hoogle for what's under the cursor, and put it in the intero buffer
  au FileType haskell noremap <silent> <buffer> <leader>iq :InteroSend<SPACE>:!hoogle<SPACE><C-R><C-W><CR>
  " qUery hoogle for a User prompted string
  au FileType haskell noremap <silent> <buffer> <leader>iu :InteroSend<SPACE>:!hoogle<SPACE>
augroup END
" }}}
" ----- junegunn/goyo.vim ----- {{{
nnoremap <silent> <leader>w :Goyo<CR>
" }}}
" ----- jez/vim-better-sml ----- {{{
" Uncomment to have same-width conceal characters
"let g:sml_greek_tyvar_show_tick = 1

"let g:sml_show_all_unused_warnings = 1
"let g:sml_hide_cmlib_unused_warnings = 1
"let g:sml_jump_to_def_new_tab = 1
"let g:sml_repl_backend = 'vimux'

let g:sml_auto_create_def_use = 'always'

augroup smlMaps
  au!
  au FileType sml nnoremap <buffer> <leader>t :SMLTypeQuery<CR>
  au FileType sml nnoremap <buffer> gd :SMLJumpToDef<CR>

  au FileType sml nnoremap <silent> <buffer> <leader>is :SMLReplStart<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>ik :SMLReplStop<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>if :SMLReplBuild<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>io :SMLReplOpen<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>iu :SMLReplUse<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>ic :SMLReplClear<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>ip :SMLReplPrintDepth<CR>
  au FileType sml nnoremap <silent> <buffer> <leader>iz :SMLReplShell<CR>
augroup END

" Check for unused variables
"let g:syntastic_sml_checkers = ["smlnj", "unused"]
" }}}
" ----- raichoo/purescript-vim ----- {{{
let g:purescript_indent_case = 2
" }}}
" ----- FrigoEU/psc-ide-vim ----- {{{
augroup pscide
  au!
  au FileType purescript nnoremap <buffer> <leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
  au FileType purescript nnoremap <buffer> <leader>S :<C-U>call PSCIDEapplySuggestion()<CR>
  au FileType purescript nnoremap <buffer> <leader>pT :<C-U>call PSCIDEaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
  au FileType purescript nnoremap <buffer> <leader>pa :<C-U>call PSCIDEaddTypeAnnotation()<CR>
  au FileType purescript nnoremap <buffer> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
  au FileType purescript nnoremap <buffer> <leader>pr :<C-U>call PSCIDEload(0)<CR>
  au FileType purescript nnoremap <buffer> <leader>pp :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
  au FileType purescript nnoremap <buffer> <leader>pc :<C-U>call PSCIDEcaseSplit("!")<CR>
  au FileType purescript nnoremap <buffer> <leader>pe :<C-U>call PSCIDEaddClause("")<CR>
  au FileType purescript nnoremap <buffer> <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
  au FileType purescript nnoremap <buffer> gd :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>
augroup END
" }}}
" ----- benmills/vimux ----- {{{
let g:VimuxOrientation = 'h'
" This is really 'width' because of the above setting
let g:VimuxHeight = '38'
let g:VimuxPromptString = '❯ '

" Focus the Vimux pane
nnoremap <silent> <leader>vi :VimuxInspectRunner<CR>

augroup vimuxMappings
  au!

  au FileType javascript nnoremap <silent> <buffer> <leader>if :VimuxRunCommand 'flow --color=always --message-width="$COLUMNS" \| less -F -X'<CR>
  au FileType javascript nnoremap <silent> <buffer> <leader>id :VimuxRunCommand 'yarn run flowdev'<CR>
  au FileType javascript nnoremap <silent> <buffer> <leader>ij :VimuxRunCommand 'yarn test '.@%<CR>
  au FileType javascript nnoremap <silent> <buffer> <leader>ik :VimuxRunCommand 'yarn run test-browser-tests-only'<CR>
  au FileType javascript nnoremap <silent> <buffer> <leader>ibk :VimuxRunCommand 'yarn run test-browser'<CR>

  au FileType haskell nnoremap <silent> <buffer> <leader>ib :VimuxRunCommand 'stack build'<CR>

  au FileType purescript nnoremap <silent> <buffer> <leader>ib :VimuxRunCommand 'pulp build'<CR>

  au FileType rust nnoremap <silent> <buffer> <leader>if :VimuxRunCommand 'cargo check \| less -F -X'<CR>
  au FileType rust nnoremap <silent> <buffer> <leader>ib :VimuxRunCommand 'cargo build \| less -F -X'<CR>
  au FileType rust nnoremap <silent> <buffer> <leader>id :VimuxRunCommand 'cargo doc --open'<CR>
  au FileType rust nnoremap <silent> <buffer> <leader>ir :VimuxRunCommand 'cargo run'<CR>

  au FileType cpp let g:VimuxResetSequence = 'qa C-u'
  " I have some shell aliases set up for building Sorbet
  au FileType cpp nnoremap <silent> <buffer> <leader>if :VimuxRunCommand 'sb'<CR>
  au FileType cpp nnoremap <silent> <buffer> <leader>it :VimuxRunCommand 'st'<CR>

  au FileType scala nnoremap <silent> <buffer> <leader>if :VimuxRunCommand 'scalac "'.bufname("%").'"'<CR>
augroup END
" }}}
" ----- fzf ----- {{{
nnoremap <C-P> :FZF<CR>

" <CR> to open in new tab, <C-E> for current buffer
let g:fzf_action = {
  \ 'ctrl-m': 'tabedit',
  \ 'ctrl-e': 'edit',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-s': 'split',
  \ 'ctrl-r': 'read',
\}

" }}}
" ----- merlin ----- {{{

" 40ms
" let g:opamconfigvarshare = system('opam config var share 2> /dev/null')
" if !v:shell_error
"   let g:opamshare = substitute(g:opamconfigvarshare,'\n$','','''')
"   execute "set rtp+=" . g:opamshare . "/merlin/vim"
" endif

" nnoremap <leader>x :MerlinClearEnclosing<CR>

" }}}
" ----- godlygeek/Tabularize ----- {{{
nnoremap <leader>\| vip:Tabularize /\|<CR><C-o>
" }}}
" ----- autozimu/LanguageClient-neovim ----- {{{
let g:LanguageClient_diagnosticsDisplay = {
      \     1: {
      \         "name": "Error",
      \         "texthl": "SpellBad",
      \         "signText": "●",
      \         "signTexthl": "LCHighlightedError",
      \         "virtualTexthl": "LCHighlightedError",
      \     },
      \     2: {
      \         "name": "Warning",
      \         "texthl": "SpellBad",
      \         "signText": "▲",
      \         "signTexthl": "LCHighlightedWarn",
      \         "virtualTexthl": "LCHighlightedWarn",
      \     },
      \     3: {
      \         "name": "Information",
      \         "texthl": "SpellBad",
      \         "signText": "ℹ",
      \         "signTexthl": "LCHighlightedInfo",
      \         "virtualTexthl": "LCHighlightedInfo",
      \     },
      \     4: {
      \         "name": "Hint",
      \         "texthl": "ALEWarning",
      \         "signText": "➤",
      \         "signTexthl": "Todo",
      \     },
      \ }
let g:LanguageClient_documentHighlightDisplay = {
      \     1: {
      \         "name": "Text",
      \         "texthl": "Search",
      \     },
      \     2: {
      \         "name": "Read",
      \         "texthl": "Search",
      \     },
      \     3: {
      \         "name": "Write",
      \         "texthl": "Search",
      \     },
      \ }
let g:LanguageClient_loggingLevel = 'INFO' " Use highest logging level
let g:LanguageClient_loggingFile = '/tmp/languageclient-neovim.log'
let g:LanguageClient_serverCommands = {}

" if split(system('hostname')) ==# ['st-jez1'] && fnamemodify(getcwd(), ':p') =~# $HOME.'/stripe/sorbet_llvm'
"   let clangd = 'bazel-sorbet_llvm/external/llvm_toolchain/bin/clangd'
"   let g:LanguageClient_serverCommands.c = ['pay', 'exec', clangd, '--path-mappings=/Users/jez/stripe/sorbet_llvm=/pay/src/sorbet_llvm']
"   let g:LanguageClient_serverCommands.cpp = ['pay', 'exec', clangd, '--path-mappings=/Users/jez/stripe/sorbet_llvm=/pay/src/sorbet_llvm']
" else
if filereadable("./compile_commands.json")
  " Some projects I work on build with Bazel, and care that they must be built
  " with a specific version of Clang and the LLVM toolchain.
  let clangd = glob('bazel-*/external/llvm_toolchain/bin/clangd', 0, 1)
  if len(clangd) == 1
    let g:LanguageClient_serverCommands.c = [clangd[0]]
    let g:LanguageClient_serverCommands.cpp = [clangd[0]]
  else
    let g:LanguageClient_serverCommands.c = ['clangd']
    let g:LanguageClient_serverCommands.cpp = ['clangd']
  endif
endif
" endif

if filereadable("build/compile_commands.json")
  " TODO(jez) Might be nice to find a platform-agnostic, suitable clangd, like above
  let g:LanguageClient_serverCommands.c = ['clangd', '--compile-commands-dir=build', '--background-index']
  let g:LanguageClient_serverCommands.cpp = ['clangd', '--compile-commands-dir=build', '--background-index']
  let g:LanguageClient_rootMarkers = ['build/compile_commands.json']
end

let g:LanguageClient_serverCommands.rust = ['rls']

function! JezLanguageClientRestart() abort
  LanguageClientStop
  LanguageClientStart
endfunction

augroup jezLanguageClient
  au!
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> <leader>cm :call LanguageClient_contextMenu()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> gd :call LanguageClient#textDocument_definition()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> <leader>t :call LanguageClient#textDocument_hover()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> K :call LanguageClient#explainErrorAtPoint()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> gy :call LanguageClient#textDocument_typeDefinition()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> <leader>ir :call LanguageClient#textDocument_references()<CR>
  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> <leader>. :call LanguageClient#textDocument_codeAction()<CR>
  au FileType ruby,rust,c,cpp inoremap <silent> <buffer> <C-g><C-p> <C-x><C-o>

  au FileType ruby,rust,c,cpp nnoremap <silent> <buffer> <leader>ik :call JezLanguageClientRestart()<CR>

  au FileType ruby let g:LanguageClient_echoProjectRoot = 0
  " Can merge this with settings.json in vim-sorbet after this lands:
  " https://github.com/autozimu/LanguageClient-neovim/pull/1112
  au FileType ruby let g:LanguageClient_settingsPath = [s:script_dir.'/settings.json', '.vim/settings.json']
augroup END
" }}}
" ----- jez/vim-sorbet ----- {{{
if fnamemodify(getcwd(), ':p') !~# $HOME.'/stripe/pay-server'
  let g:sorbet_lsp_extra_args = ['--debug-log-file=/tmp/sorbet-nvim.log']
endif
" }}}
" ----- puremourning/vimspector ----- {{{
let g:vimspector_install_gadgets = ['vscode-cpptools', 'CodeLLDB']

nmap <leader>gc <Plug>VimspectorContinue
nmap <leader>gq <Plug>VimspectorStop
nmap <leader>gr         <Plug>VimspectorRestart
nmap <leader>gp         <Plug>VimspectorPause
nmap <leader>gb <Plug>VimspectorToggleBreakpoint
nmap <leader>gm <Plug>VimspectorAddFunctionBreakpoint
nmap <leader>gn <Plug>VimspectorStepOver
nmap <leader>gs <Plug>VimspectorStepInto
nmap <leader>gf <Plug>VimspectorStepOut
nmap <leader>gi <Plug>VimspectorBalloonEval
nnoremap <leader>ge :VimspectorEval<CR>
nnoremap <leader>gx :VimspectorEval<CR>-exec<space>
nnoremap <leader>gw :VimspectorWatch<CR>
nnoremap <leader>gz :VimspectorReset<CR>
nnoremap <leader>go :call feedkeys(":VimspectorShowOutput \<Tab>", 'tn')<CR>
" " These are some unmapped mappings
" nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
" nmap <leader><F8> <Plug>VimspectorRunToCursor

sign define vimspectorBP         text=\ ● texthl=LCHighlightedError
sign define vimspectorBPCond     text=\ ◆ texthl=LCHighlightedError
sign define vimspectorBPDisabled text=\ ● texthl=LCHighlightedInfo
sign define vimspectorPC         text=\ ▶ texthl=LCHighlightedWarn linehl=CursorLine
sign define vimspectorPCBP       text=●▶  texthl=LCHighlightedWarn linehl=CursorLine
" sign vimspectorCurrentThread text=▶  texthl=MatchParen linehl=CursorLine

let g:vimspector_sidebar_width = 80

" " works but looks bad
" au User VimspectorUICreated call nvim_win_close(g:vimspector_session_windows.watches, v:false)

" }}}
" ----- Shougo/deoplete.nvim ----- {{{
" augroup jezDeoplete
"   au!
"   au FileType ruby nnoremap <silent> <buffer> <leader>ic :call deoplete#enable()<CR>
" augroup END

" call deoplete#custom#option('sources', {
" \ '_': [],
" \ 'ruby': ['LanguageClient'],
" \})
" }}}
" ----- neoclide/coc.nvim ----- {{{
" augroup jezCocVim
"   au!
"   au FileType ruby nnoremap <silent> <buffer> <leader>t :call CocAction('doHover')<CR>
"   au FileType ruby nnoremap <silent> <buffer> gd <Plug>(coc-definition)
"   au FileType ruby nnoremap <silent> <buffer> gy <Plug>(coc-type-definition)
"   au FileType ruby nnoremap <silent> <buffer> ge <Plug>(coc-diagnostic-info)
" augroup END
" inoremap <silent> <expr> <c-space> coc#refresh()
" }}}
" ----- AnsiEsc.vim ----- {{{
let g:no_cecutil_maps = 1
" }}}
" ----- Builtin Vim plugins ----- {{{
" When viewing directories, show nested tree mode
let g:netrw_liststyle=3
" Don't create .netrwhist files
let g:netrw_dirhistmax = 0
let g:yacc_uses_cpp = 1

" }}}

" -----------------------------------------------------------------------------
" vim:ft=vim fdm=marker
