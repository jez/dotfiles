" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		      " show the cursor position all the time
                  " clock
" set rulerformat=%55(%{strftime('%I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set showcmd		    " display incomplete commands
set incsearch		  " do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  au BufRead,BufNewFile *.md setlocal spell
  au BufRead,BufNewFile *.tex setlocal spell
  au BufRead,BufNewFile * normal zR

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal columns=78
  "au BufRead,BufNewFile *.md setlocal columns=80
  au BufNewFile,BufRead *.sig set filetype=sml

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" =========================================================================== "
"                                                                             "
"                                 MY CHANGES                                  "
"                                                                             "
" =========================================================================== "

" ----- Pathogen and Plugins -------------------------------------------------
set rtp+=~/.vim/bundle/pathogen
execute pathogen#infect()

Helptags

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
set laststatus=2
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'solarized'
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

" delimitMate settings
let delimitMate_expand_cr = 1
au BufRead,BufNewFile *.md let b:delimitMate_nesting_quotes = ["`"]

" Tagbar settings
nmap <silent> <leader>b :TagbarToggle<CR>

" EasyTags settings
set tags=./tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1

" Syntastic settings
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
au BufRead,BufNewFile *.tex let b:syntastic_mode = "passive"

" Solarized settings
set background=dark
colorscheme solarized

" vim-gitgutter settings
hi clear SignColumn
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1

" vim-markdown settings
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

" vim-notes settings
let g:notes_directories = ['~/Dropbox/Notes']
let g:notes_suffix = '.txt'

" ----------------------------------------------------------------------------

" Tab settings
set expandtab          "Expand tabs into spaces
set tabstop=2          "default to 2 spaces for a hard tab
set softtabstop=2      "default to 2 spaces for the soft tab
set shiftwidth=2       "for when <TAB> is pressed at the beginning of a line

" Use a backup file but don't create a new one when overwriting
" :help nobackup for more information
set nobackup
set writebackup

" Line numbers
set number

" Make it so that these commands don't complain
command WQ wq
command Wq wq
command Wqa wqa
command W w
command Q q

" Save readonly files using sudo
command WS w !sudo tee %

" Helper commands for running Make with my Makefiles
command V make view
command Wv w | make view
command WV w | make view

" Use :C to clear hlsearch
command C noh

set linebreak
set scrolloff=3

" Make it so that using long, wrapped lines will behave like normal lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
noremap <buffer> <silent> ^ g^
noremap <buffer> <silent> _ g_

" take first suggested spelling as correct spelling and replace
noremap <buffer> <silent> z! z=1<CR><CR>

" use 'Y' to yank to the end of a line
noremap <buffer> <silent> Y y$

" use ~ to toggle case as an operator, not a motion
set tildeop

" better manpage support
source $VIMRUNTIME/ftplugin/man.vim

" Show nested tree mode when viewing directories
let g:netrw_liststyle=3

" \c and \C to comment and uncomment lines in visual block mode
noremap <buffer> <silent> <leader>c :s/^/\/\//<CR>:noh<CR>
noremap <buffer> <silent> <leader>C :s/^\/\///<CR>:noh<CR>

" \f to make manual folds on { or }
noremap <buffer> <silent> <leader>f V%zf

" set get rid of obnoxious '-' characters in folds
set fillchars=fold:\ ,

" open help in a new tab
cabbrev help tab help

" qt or tq to close tab
cabbrev qt tabclose
cabbrev tq tabclose
command Qt qt
command QT qt
command Tq qt
command TQ qt

" Lower ^[ timeout
set timeoutlen=100

" Vertical splits use right half of screen
set splitright
