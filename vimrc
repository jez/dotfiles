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

" ----- General Settings  ----------------------------------------------- {{{

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
scriptencoding utf-8
" vint: -ProhibitSetNoCompatible
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1000       " keep 1000 lines of command line history
set number             " line numbers
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching
if exists('&inccommand')
  set inccommand=split " like incsearch, but do it for commands (like :s)
endif
set linebreak          " wrap lines on 'word' boundaries
set scrolloff=3        " don't let the cursor touch the edge of the viewport
set splitright         "   Vertical splits  use   right half  of screen
set splitbelow         " Horizontal splits  use  bottom half  of screen
set timeoutlen=1000    " Lower ^[ timeout
set fillchars=fold:\ , " get rid of obnoxious '-' characters in folds
set tildeop            " use ~ to toggle case as an operator, not a motion
set colorcolumn=+0     " show a column whenever textwidth is set
if exists('&breakindent')
  set breakindent      " Indent wrapped lines up to the same level
endif
set foldnestmax=1      " Only fold up to one level deep
set list               " Show certain non-printing characters as printed
set listchars-=trail:- " Don't show trailing whitespace in listchars output
                       " (I use vim-better-whitespace for trailing whitespace)
set listchars-=eol:$   " Don't show trailing end-of-line characters
                       " (I use vim-better-whitespace for trailing whitespace)

" Show potential matches above completion, complete first immediately
set wildmenu
set wildmode=full

" Tab settings
set expandtab          " Expand tabs into spaces
set tabstop=2          " default to 2 spaces for a hard tab
set softtabstop=2      " default to 2 spaces for the soft tab
set shiftwidth=2       " for when <TAB> is pressed at the beginning of a line
set cinkeys-=0#        " Let #pragma directives appear anywhere in a line

" }}}
" ----- Convenience commands and cabbrev's ------------------------------ {{{

" Make these commonly mistyped commands still work
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang Wqa wqa<bang>
command! -bang W w<bang>
command! -bang Q q<bang>

" Use :C to clear hlsearch
command! C nohlsearch

" Force write readonly files using sudo
command! WS w !sudo tee %

" open help in a new tab
cabbrev help tab help

" My LaTeX Makefiles all have a `view` target which compiles and opens the PDF
" This command saves the file then runs that target
command! Wv w | make view
command! WV w | make view

" Open terminal in a split split
command! Vte vsplit | terminal
command! Ste split | terminal

" }}}
" ----- Custom keybindings ---------------------------------------------- {{{

map <space> <leader>
nnoremap <CR> :
nnoremap s <nop>
nnoremap <M-Enter> <CR>
nnoremap S <nop>

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> 0 g0
noremap <silent> g0 0
noremap <silent> $ g$
noremap <silent> g$ $
noremap <silent> ^ g^
noremap <silent> g^ ^
noremap <silent> _ g_

" use 'Y' to yank to the end of a line, instead of the whole line
nnoremap <silent> Y y$

" take first suggested spelling as correct spelling and replace
nnoremap <silent> <leader>z z=1<CR><CR>

nnoremap <leader>ww :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <silent> <leader>v :WV<CR>

" See Vte command above
nnoremap <silent> <leader>v :Vte<CR>

map <leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Easier to type on my keyboard than gt and gT
noremap <silent> gr gt
noremap <silent> gR gT

nnoremap <leader>y "+y
vnoremap <silent> <leader>y "+y

" Neovim Terminal Emulator keys
if has('nvim')
  tnoremap <M-e> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" }}}
" ----- Terminal-as-GUI settings ---------------------------------------- {{{

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif

if exists('+termguicolors')
  " This lets us use 24-bit "true" colors in the terminal
  set termguicolors
endif

" NeoVim and iTerm2 have support to display different cursor shapes than just
" the standard white block.
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" }}}
" ----- Not-quite-general-but-don't-belong-anywhere-else Settings ------- {{{

augroup vimrc
  " Clear the current autocmd group, in case we're re-sourcing the file
  au!

  " Jump to the last known cursor position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" }}}
" ----- Filetype Settings ----------------------------------------------- {{{

" Enable file type detection.
filetype plugin indent on

augroup myFiletypes
  au!

  " Patch filetypes for common extensions

  " Markdown files
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  " Treat all .tex files as latex
  au BufRead,BufNewFile *.tex setlocal filetype=tex
  " LaTeX class files
  au BufRead,BufNewFile *.cls setlocal filetype=tex
  " Amethyst config file
  au BufRead,BufNewFile .amethyst setlocal filetype=json
  " jrnl config file
  au BufRead,BufNewFile .jrnl_config setlocal filetype=json
  " Processing Java file
  au BufRead,BufNewFile *.pde setlocal filetype=java
  " Gradle files
  au BufRead,BufNewFile *.gradle setlocal filetype=groovy
  " gitconfig files
  au BufRead,BufNewFile gitconfig setlocal filetype=gitconfig
  " JavaScript linting files
  au BufRead,BufNewFile .eslintrc setlocal filetype=json
  au BufRead,BufNewFile .jscsrc setlocal filetype=json
  " 15-411 intermediate language filetypes
  au BufRead,BufNewFile *.l1 setlocal filetype=c0
  au BufRead,BufNewFile *.l2 setlocal filetype=c0
  au BufRead,BufNewFile *.l3 setlocal filetype=c0
  au BufRead,BufNewFile *.l4 setlocal filetype=c0
  " SQLite-specific file
  au BufRead,BufNewFile *.sqlite setlocal filetype=sql

  " Turn on spell checking and 80-char lines by default for these filetypes
  au FileType pandoc,markdown,tex setlocal spell
  au FileType pandoc,markdown,tex setlocal tw=80

  " Always use tabs
  au FileType gitconfig setlocal noexpandtab
  au FileType go setlocal noexpandtab

  " Use coneal characters with SML
  au FileType sml setlocal conceallevel=2
  au FileType mllex setlocal conceallevel=2
  au FileType mlyacc setlocal conceallevel=2

  " Use coneal characters with LaTeX
  au FileType tex setlocal conceallevel=2

  " Reset concealcursor in Vim help
  au FileType help setlocal concealcursor=

  " Wrap long lines in quickfix windows
  au FileType qf setlocal wrap
  " Set cursorline in quickfix windows
  au FileType qf setlocal cursorline

augroup END

" }}}
" ----- Pathogen and Plugin Settings ------------------------------------ {{{

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
" Disable this because it causes an issue with FZF + NeoVim
" https://github.com/neovim/neovim/issues/4487
let g:airline#extensions#branch#enabled = 0
" Don't try to re-init tmuxline every time (I've made special modifications)
let g:airline#extensions#tmuxline#enabled = 0

" }}}
" ----- Raimondi/delimitMate settings ----- {{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_excluded_regions = ''
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType pandoc let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType coffee let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" }}}
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

" }}}
" ----- xolox/vim-easytags settings ----- {{{
set tags=./tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

let g:easytags_languages = {
\   'javascript.jsx': {
\     'cmd': '~/bin/gtags',
\     'stdout_opt': '-f -'
\   }
\ }
" }}}
" " ----- scrooloose/syntastic settings ----- {{{
" let g:syntastic_error_symbol = '✘'
" let g:syntastic_warning_symbol = "▲"
" let g:syntastic_check_on_wq = 0
" augroup mySyntastic
"   au!
"   au FileType tex let b:syntastic_mode = "passive"
"   au BufRead,BufNewFile *.cjsx let b:syntastic_mode = "passive"
"   au FileType typescript let b:syntastic_mode = "passive"
"   au FileType cpp let b:syntastic_mode = "passive"

"   " Disabled; handled by Neomake
"   au FileType javascript let b:syntastic_mode = "passive"
"   au FileType css let b:syntastic_mode = "passive"

"   au FileType sml let g:syntastic_always_populate_loc_list = 1
"   au FileType sml let g:syntastic_auto_loc_list = 1

"   au FileType purescript let g:syntastic_auto_loc_list = 1
" augroup END

" nnoremap <leader>ST :SyntasticToggleMode<CR>
" nnoremap <leader>SR :SyntasticReset<CR>

" " Follow `source` statements in shell code
" let g:syntastic_sh_shellcheck_args = "-x"

" " }}}
" ----- neomake/neomake ----- {{{
" Use neomake only as a dependency for other plugins. Otherwise, prefer ALE.
let g:neomake_error_sign = {
    \ 'text': '✘',
    \ 'texthl': 'Error',
    \ }
let g:neomake_warning_sign = {
    \ 'text': '▲',
    \ 'texthl': 'Todo',
    \ }

let g:neomake_open_list = 1

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

nnoremap <leader>AT :ALEToggle

let g:ale_linters = {
  \ 'tex': [],
  \ 'haskell': [],
  \ }
" }}}
" ----- altercation/vim-colors-solarized settings ----- {{{
if $SOLARIZED ==? 'dark'
  set background=dark
elseif $SOLARIZED ==? 'light'
  set background=light
else
  set background=dark
endif

" Uncomment the next line if your terminal is not configured for solarized
"let g:solarized_termcolors=256

" Set the colorscheme
colorscheme solarized

" Remove the underline Solarized places under Folded previews
hi! Folded cterm=NONE term=NONE

hi link helpCommand Constant

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
" }}}
" ----- mxw/vim-jsx ----- {{{
" Syntax highlighting for JSX
let g:jsx_ext_required = 0

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
  au Filetype pandoc nnoremap <TAB> >>
  au Filetype pandoc nnoremap <S-TAB> <<
  au Filetype pandoc inoremap <TAB> <C-t>
  au Filetype pandoc inoremap <S-TAB> <C-d>
augroup END

" }}}
" ----- vim-pandoc/vim-pandoc-syntax ----- {{{
let g:pandoc#syntax#use_definition_lists = 0
" }}}
" ----- mhinz/grepper ----- {{{
let g:grepper = {
    \ 'tools': ['ag', 'git', 'grep'],
    \ 'open':  1,
    \ 'jump':  0,
    \ 'highlight':  1,
    \ }

nnoremap <leader>a :Grepper<CR>
nnoremap <leader>* :Grepper -cword -noprompt<CR>

" }}}
" ----- romainl/vim-qf ----- {{{
" Because grepper no longer has keybindings in the Quickfix window
let g:qf_mapping_ack_style = 1
" }}}
" ----- parsonsmatt/intero-neovim ----- {{{
augroup interoMaps
  au!

  au BufWritePost *.hs InteroReload

  au FileType haskell nnoremap <leader>io :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <leader>ik :InteroKill<CR>
  au FileType haskell nnoremap <leader>ih :InteroHide<CR>

  au FileType haskell nnoremap <leader>ir :InteroReload<CR>
  au FileType haskell nnoremap <leader>il :InteroLoadCurrentModule<CR>

  au FileType haskell nnoremap <leader>t :InteroGenericType<CR>
  au FileType haskell nnoremap <leader>T :InteroType<CR>
  au FileType haskell nnoremap <leader>ii :InteroInfo<CR>

  au FileType haskell nnoremap <leader>jd :InteroGoToDef<CR>
  au FileType haskell nnoremap <leader>iu :InteroUses<CR>
augroup END


" }}}
" ----- junegunn/goyo.vim ----- {{{
nnoremap <silent> <leader>W :Goyo<CR>
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
  au FileType purescript nnoremap <leader>t :PSCIDEtype<CR>
  au FileType purescript nnoremap <leader>S :PSCIDEapplySuggestion<CR>
  au FileType purescript nnoremap <leader>pa :PSCIDEaddTypeAnnotation<CR>
  au FileType purescript nnoremap <leader>i :PSCIDEimportIdentifier<CR>
  au FileType purescript nnoremap <leader>L :PSCIDEload<CR>
  au FileType purescript nnoremap <leader>pp :PSCIDEpursuit<CR>
  au FileType purescript nnoremap <leader>pc :PSCIDEcaseSplit<CR>
  au FileType purescript nnoremap <leader>qd :PSCIDEremoveImportQualifications<CR>
  au FileType purescript nnoremap <leader>qa :PSCIDEaddImportQualifications<CR>
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
" }}}
" -----------------------------------------------------------------------------
" vim:ft=vim fdm=marker
