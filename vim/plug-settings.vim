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
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', ' %3v'])

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
" ----- majutsushi/tagbar settings ----- {{{
" Open/close tagbar with \b
nnoremap <silent> <leader>b :TagbarToggle<CR>

" Always open tagbar for CoffeeScript files
"au! FileType coffee TagbarOpen

" Order tags based on file order; don't sort alphabetically
let g:tagbar_sort = 0
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" Treat .ts in Vim as .ts in ctags
"let g:tagbar_type_typescript = {
"  \ 'ctagstype': 'typescript',
"  \ 'kinds': [
"    \ 'c:classes',
"    \ 'n:modules',
"    \ 'f:functions',
"    \ 'v:variables',
"    \ 'v:varlambdas',
"    \ 'm:members',
"    \ 'i:interfaces',
"    \ 'e:enums',
"  \ ]
"\ }

" Treat .ts in Vim as .js in ctags
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'JavaScript',
  \ 'kinds': [
    \ 'f:functions',
    \ 'c:classes',
    \ 'm:members',
    \ 'p:properties',
    \ 'v:globals',
  \ ]
\ }

let g:tagbar_type_javascript = {
  \ 'ctagstype': 'js',
  \ 'replace': 1,
  \ 'ctagsbin': '~/bin/gtags',
  \ 'kinds': [
    \ 'c:class',
    \ 'm:method',
    \ 'p:property',
    \ 'f:function',
    \ 'o:object',
    \ 'n:constant',
  \ ],
\ }

let g:tagbar_type_coffee = {
  \ 'ctagstype': 'CoffeeScript',
  \ 'kinds': [
    \ 'n:constants',
    \ 'c:classes',
    \ 'm:methods',
    \ 'f:functions',
  \ ]
\ }

if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds' : [
          \ 'm:modules',
          \ 'c:classes',
          \ 'f:methods',
          \ 'F:singleton methods',
          \ 'C:constants',
          \ 'a:aliases'
      \ ],
      \ 'ctagsbin': 'ripper-tags',
      \ 'ctagsargs': '--fields=+n -f -'
  \ }
endif

let g:tagbar_type_eruby = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Headings',
    \ ]
    \ }

" }}}
" ----- xolox/vim-easytags settings ----- {{{
set tags=./tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" \     'stdout_opt': '-f -'
" \     'stdout_opt': '-f -'
let g:easytags_languages = {
\   'javascript.jsx': {
\     'cmd': '~/bin/gtags'
\   },
\   'ruby': {
\     'cmd': 'ripper-tags'
\   }
\ }

" }}}
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
" Note: you'll have to run 'stack build ghc-mod' once per project
let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint']
" For stripe: use 'erubis' instead of 'erubylint'
let g:ale_linters.eruby = ['erubis']
" CSS warnings were mostly chunderous
let g:ale_linters.css = []

" Be sure to never install 'prettier' globally, or you will be running
" prettier on all JavaScript files everywhere.
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.css = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_rust_cargo_check_all_targets = 0

augroup aleMaps
  au FileType javascript let g:ale_fix_on_save = 1
  au FileType css let g:ale_fix_on_save = 1
augroup END

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
" }}}
" ----- airblade/vim-gitgutter settings ----- {{{
hi clear SignColumn

nnoremap <leader>ht :GitGutterLineHighlightsToggle<CR>
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
" ----- tpope/vim-fugitive settings ----- {{{


" }}}
" ----- tpope/vim-rhubarb settings ----- {{{

let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" }}}
" ----- jez/vim-superman settings ----- {{{
" better man page support
noremap K :SuperMan <cword><CR>

" }}}
" ----- pangloss/vim-javascript ----- {{{
let g:javascript_conceal_function       = 'λ'
let g:javascript_conceal_null           = 'ø'
let g:javascript_conceal_this           = '@'
"let g:javascript_conceal_return         = '⇚'
let g:javascript_conceal_undefined      = '¿'
"let g:javascript_conceal_NaN            = 'ℕ'
"let g:javascript_conceal_prototype      = '¶'
"let g:javascript_conceal_static         = '•'
"let g:javascript_conceal_super          = 'Ω'
"let g:javascript_conceal_arrow_function = '⇒'

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
  au FileType javascript nnoremap <leader>t :FlowType<CR>
  au FileType javascript nnoremap gd :FlowJumpToDef<CR>
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
let g:pandoc#syntax#codeblocks#embeds#langs = ['python', 'sml', 'zsh', 'c']
let g:pandoc#syntax#conceal#blacklist = ['image', 'atx', 'codeblock_delim']
let g:pandoc#formatting#mode = 'h'

augroup pandocSettings
  au!

  " Auto-populate next line with things like blockquotes '>'
  au FileType pandoc setlocal formatoptions+=c

  " Indent and de-indent with TAB and SHIFT + TAB
  au FileType pandoc nnoremap <TAB> >>
  au FileType pandoc nnoremap <S-TAB> <<
  au FileType pandoc inoremap <TAB> <C-t>
  au FileType pandoc inoremap <S-TAB> <C-d>
augroup END

" }}}
" ----- vim-pandoc/vim-pandoc-syntax ----- {{{
let g:pandoc#syntax#use_definition_lists = 0
" }}}
" ----- mhinz/grepper ----- {{{
let g:grepper = {}
" Only use ag for grepping
let g:grepper.tools = ['ag']
" Highlight search matches (like it were hlsearch)
let g:grepper.highlight = 1
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
let g:haskell_indent_let_no_in = 0
let g:haskell_indent_if = 2
let g:haskell_indent_before_where = 2
let g:haskell_classic_highlighting = 1
" }}}
" ----- alx471/vim-hindent ----- {{{
" TODO(jez) If brittany works out, remove hindent Vim plugin
let g:hindent_on_save = 0
" }}}
" ----- sbdchd/neoformat ----- {{{
let g:neoformat_enabled_haskell = ['brittany', 'stylish-haskell']
augroup neoformatMaps
  au!
  au FileType haskell nnoremap <leader>hf :Neoformat \| :w<CR>
  au FileType haskell let g:neoformat_run_all_formatters = 1
augroup END
" }}}
" ----- parsonsmatt/intero-neovim ----- {{{
let g:intero_start_immediately = 0
let g:intero_use_neomake = 1

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>ir :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>
  " au FileType haskell nnoremap <silent> <leader>ii :InteroInfo<CR>

  au FileType haskell nnoremap <silent> gd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>

  " hoogle bindings (stack install hoogle && hoogle generate)

  " Query hoogle for what's under the cursor, and put it in the intero buffer
  au FileType haskell noremap <silent> <leader>iq :InteroSend<SPACE>:!hoogle<SPACE><C-R><C-W><CR>
  " qUery hoogle for a User prompted string
  au FileType haskell noremap <leader>iu :InteroSend<SPACE>:!hoogle<SPACE>
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

augroup smlMaps
  au!
  au FileType sml nnoremap <leader>t :SMLTypeQuery<CR>
  au FileType sml nnoremap gd :SMLJumpToDef<CR>
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
  au FileType purescript nnoremap <leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
  au FileType purescript nnoremap <leader>S :<C-U>call PSCIDEapplySuggestion()<CR>
  au FileType purescript nnoremap <leader>pT :<C-U>call PSCIDEaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
  au FileType purescript nnoremap <leader>pa :<C-U>call PSCIDEaddTypeAnnotation()<CR>
  au FileType purescript nnoremap <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
  au FileType purescript nnoremap <leader>pr :<C-U>call PSCIDEload(0)<CR>
  au FileType purescript nnoremap <leader>pp :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
  au FileType purescript nnoremap <leader>pc :<C-U>call PSCIDEcaseSplit("!")<CR>
  au FileType purescript nnoremap <leader>pe :<C-U>call PSCIDEaddClause("")<CR>
  au FileType purescript nnoremap <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
  au FileType purescript nnoremap gd :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>
augroup END
" }}}
" ----- benmills/vimux ----- {{{
let g:VimuxOrientation = 'h'
" This is really 'width' because of the above setting
let g:VimuxHeight = '50'
let g:VimuxPromptString = '❯ '

nnoremap <silent> <leader><up> :VimuxRunLastCommand<CR>
nnoremap <silent> <leader>vp :VimuxPromptCommand<CR>

augroup vimuxMappings
  au!

  au FileType javascript nnoremap <silent> <leader>if :VimuxRunCommand 'flow --color=always \| less -F -X'<CR>
  au FileType javascript nnoremap <silent> <leader>id :VimuxRunCommand 'yarn run flowdev'<CR>

  au FileType haskell nnoremap <silent> <leader>ib :VimuxRunCommand 'stack build'<CR>

  au FileType purescript nnoremap <silent> <leader>ib :VimuxRunCommand 'pulp build'<CR>

  au FileType rust nnoremap <silent> <leader>if :VimuxRunCommand 'cargo check \| less -F -X'<CR>
  au FileType rust nnoremap <silent> <leader>ib :VimuxRunCommand 'cargo build \| less -F -X'<CR>
  au FileType rust nnoremap <silent> <leader>id :VimuxRunCommand 'cargo doc --open'<CR>
  au FileType rust nnoremap <silent> <leader>ir :VimuxRunCommand 'cargo run'<CR>
augroup END
" }}}
" ----- fzf ----- {{{
set runtimepath+=/usr/local/opt/fzf
set runtimepath+=/afs/cs/academic/class/15131-f15/opt/fzf
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
" ----- Builtin Vim plugins ----- {{{
" When viewing directories, show nested tree mode
let g:netrw_liststyle=3
" Don't create .netrwhist files
let g:netrw_dirhistmax = 0

" }}}

" -----------------------------------------------------------------------------
" vim:ft=vim fdm=marker

