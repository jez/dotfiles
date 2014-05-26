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
  " au BufRead,BufNewFile *.md set filetype=markdown

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

" MY CHANGES

" Pathogen
call pathogen#infect()

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

command V make view
command Wv w | make view
command WV w | make view

command Clear noh

colorscheme molokai

set linebreak
set scrolloff=3

" Turn on syntax completion
set omnifunc=syntaxcomplete#Complete

" Make it so that using long, wrapped lines will behave like normal lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
noremap <buffer> <silent> ^ g^
noremap <buffer> <silent> _ g_
noremap <buffer> <silent> gA g$a
noremap <buffer> <silent> gI I
noremap <buffer> <silent> I g^i

" take first suggested spelling as correct spelling and replace
noremap <buffer> <silent> z! z=1<CR><CR>

" use 'Y' to yank to the end of a line
noremap <buffer> <silent> Y y$

" use ~ to toggle case as an operator, not a motion
set tildeop

" better manpage support
source $VIMRUNTIME/ftplugin/man.vim

" Octopress coloring
autocmd BufNewFile,BufRead *.md,*.markdown,*.textile set filetype=octopress

let g:netrw_liststyle=3
