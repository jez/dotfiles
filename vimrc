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

" ----- General Settings  -----------------------------------------------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1000       " keep 1000 lines of command line history
set number             " line numbers
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching
set linebreak          " wrap lines on 'word' boundaries
set scrolloff=3        " don't let the cursor touch the edge of the viewport
set splitright         "   Vertical splits  use   right half  of screen
set splitbelow         " Horizontal splits  use  bottom half  of screen
set timeoutlen=1000     " Lower ^[ timeout
set fillchars=fold:\ , " get rid of obnoxious '-' characters in folds
set tildeop            " use ~ to toggle case as an operator, not a motion
set colorcolumn=+0     " show a column whenever textwidth is set
if exists('&breakindent')
  set breakindent      " Indent wrapped lines up to the same level
endif

" Show potential matches above completion, complete first immediately
set wildmenu
set wildmode=full

" Tab settings
set expandtab          " Expand tabs into spaces
set tabstop=2          " default to 2 spaces for a hard tab
set softtabstop=2      " default to 2 spaces for the soft tab
set shiftwidth=2       " for when <TAB> is pressed at the beginning of a line

" ----- Convenience commands and cabbrev's ------------------------------------

" Make these commonly mistyped commands still work
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

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

" ----- Custom keybindings ----------------------------------------------------

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> _ g_

" use 'Y' to yank to the end of a line, instead of the whole line
noremap <silent> Y y$

" take first suggested spelling as correct spelling and replace
noremap <silent> z! z=1<CR><CR>
" NOTE: This feature requires a longer timeoutlen. To use it, up the
"       timeoutlen above.

" ----- Terminal-as-GUI settings ----------------------------------------------

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" ----- Not-quite-general-but-don't-belong-anywhere-else Settings -------------

augroup vimrc
  " Clear the current autocmd group, in case we're re-sourcing the file
  au!

  " Jump to the last known cursor position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" ----- Filetype Settings -----------------------------------------------------

" Enable file type detection.
filetype plugin indent on

augroup myFiletypes
  au!

  " Patch filetypes for common extensions

  " SML signature files
  au BufRead,BufNewFile *.sig setlocal filetype=sml
  " Markdown files
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  " LaTeX class files
  au BufRead,BufNewFile *.cls setlocal filetype=tex
  " Amethyst config file
  au BufRead,BufNewFile .amethyst setlocal filetype=json
  " jrnl config file
  au BufRead,BufNewFile .jrnl_config setlocal filetype=json

  " Turn on spell checking and 80-char lines by default for these filetypes
  au FileType markdown,tex setlocal spell
  au FileType markdown,tex setlocal tw=80

augroup END

" ----- Pathogen and Plugin Settings ------------------------------------------

" Pathogen is in a non-standard location: modify the rtp to reflect that
set rtp+=~/.vim/bundle/pathogen

" Let Pathogen take over the runtimepath to make plugins in ~/.vim/bundle work
execute pathogen#infect()

" Generate all helptags on startup
Helptags

" ----- bling/vim-airline settings -----
" Fancy arrow symbols, requires a patched font
let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Always show statusbar
set laststatus=2
" Slightly modify the theme colors
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'solarized' && g:solarized_termcolors == 16
    " normal mode background: s:base03
    let a:palette.normal.airline_a[2] = 8
    " normal mode foreground: s:green
    let a:palette.normal.airline_a[3] = 2

    " line no. background: s:base03
    let a:palette.normal.airline_z[2] = 8
    " line no. foreground: s:green
    let a:palette.normal.airline_z[3] = 2
  endif
endfunction
let g:airline#extensions#tabline#enabled = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nnoremap <silent> <leader>b :TagbarToggle<CR>
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

" ----- xolox/vim-easytags settings -----
set tags=./tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
  au BufRead,BufNewFile *.cjsx let b:syntastic_mode = "passive"
  au FileType typescript let b:syntastic_mode = "passive"
augroup END

" ----- altercation/vim-colors-solarized settings -----
" Toggle this to "light" for light colorscheme
set background=dark

" Uncomment the next line if your terminal is not configured for solarized
"let g:solarized_termcolors=256

" Set the colorscheme
colorscheme solarized

" Remove the underline Solarized places under Folded previews
hi! Folded cterm=NONE term=NONE

" ----- airblade/vim-gitgutter settings -----
hi clear SignColumn
let g:airline#extensions#hunks#non_zero_only = 1

" ----- jez/vim-superman settings -----
" better man page support
noremap K :SuperMan <cword><CR>

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
nnoremap <silent> <leader>t :NERDTreeTabsToggle<CR>

" ----- mxw/vim-jsx -----
" Syntax highlighting for JSX
let g:jsx_ext_required = 0

" ----- ntpeters/vim-better-whitespace -----
" Don't highlight whitespace in git commit messages (for diffs)...
let g:better_whitespace_filetypes_blacklist=['gitcommit']
" ... but strip it on save so that we're still safe
autocmd FileType gitcommit autocmd BufWritePre <buffer> StripWhitespace

" ----- fzf -----
set rtp+=/usr/local/Cellar/fzf/HEAD
nnoremap <C-P> :FZF<CR>

" <CR> to open in new tab, <C-E> for current buffer
let g:fzf_action = {
  \ 'ctrl-m': 'tabedit',
  \ 'ctrl-e': 'edit',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-s': 'split',
  \ 'ctrl-r': 'read',
\}

" ----- Builtin Vim plugins -----
" When viewing directories, show nested tree mode
let g:netrw_liststyle=3
" Don't create .netrwhist files
let g:netrw_dirhistmax = 0

" -----------------------------------------------------------------------------
" vim:ft=vim
