"
" File:       settings.vim
" Author:     Jake Zimmerman <jake@zimmerman.io>
" Created:    2017-08-15
"

" ----- General settings ----------------------------------------------------

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
set splitright         " Vertical   splits  use  right  half  of screen
set splitbelow         " Horizontal splits  use  bottom half  of screen
set timeoutlen=1000    " Lower ^[ timeout
set fillchars=fold:\ , " get rid of obnoxious '-' characters in folds & diffs
set fillchars+=diff:\ ,
set tildeop            " use ~ to toggle case as an operator, not a motion
set colorcolumn=+0     " show a column whenever textwidth is set
if exists('&breakindent')
  set breakindent      " Indent wrapped lines up to the same level
endif
set foldnestmax=4      " Only fold up to one level deep
set list               " Show certain non-printing characters as printed
set listchars-=trail:- " Don't show trailing whitespace in listchars output
                       " (I use vim-better-whitespace for trailing whitespace)
set listchars-=eol:$   " Don't show trailing end-of-line characters
                       " (I use vim-better-whitespace for trailing whitespace)
set noshowmode         " Don't show "-- INSERT --" in insert mode
                       " Preseves things like echo'd messages
set cinkeys-=0#        " Let #pragma directives appear anywhere in a line

" Show potential matches above completion, complete first immediately
set wildmenu
set wildmode=full

" Tab settings
set expandtab          " Expand tabs into spaces
set tabstop=2          " default to 2 spaces for a hard tab
set softtabstop=2      " default to 2 spaces for the soft tab
set shiftwidth=2       " for when <TAB> is pressed at the beginning of a line

" Enable file type detection.
filetype plugin indent on

" ----- Convenience commands and cabbrev's ----------------------------------

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

" Open new (empty) buffer in a split on left
command! Vsnew vert new | norm <C-w>H

" Replace curly quotes with straight quotes in the entire file.
function! Nocurly() abort
  " vint: -ProhibitCommandWithUnintendedSideEffect
  " vint: -ProhibitCommandRelyOnUser
  silent! %s/‘/'/g
  silent! %s/’/'/g
  silent! %s/“/"/g
  silent! %s/”/"/g
  " vint: +ProhibitCommandRelyOnUser
  " vint: +ProhibitCommandWithUnintendedSideEffect
endfunction
command! Nocurly call Nocurly()

" Merge current tab with the tab to the left
noremap <C-w>m :Tabmerge right<CR>

" ----- Custom keybindings --------------------------------------------------

" <space> is usually a motion meaning the same as 'l' (one letter forward)
" Much more useful if we make it be <leader>!
" (Uses map instead of mapleader so that this doesn't affect insert mode.)
map <space> <leader>

" 'Enter' is easier for me to hit on my keyboard than :
noremap <CR> :

" I have no use for this (it's the same as C)
noremap S <nop>

" This always messes me up
noremap K <nop>
noremap Q <nop>

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> ^ g^
noremap <silent> g^ ^
noremap <silent> _ g_

" Highlight the current word under the cursor (instead of highlight + next)
nnoremap * :keepjumps normal! *N<CR>
nnoremap # :keepjumps normal! #N<CR>

" Recursive to pick up the * mapping
nmap g* *:vimgrep // %<CR>
nmap g# #:vimgrep // %<CR>

" goto file in new tab, instead of in current buffer
nnoremap <silent> gf <C-W>gf
nnoremap <silent> gF <C-W>gF
vnoremap <silent> gf <C-W>gf
vnoremap <silent> gF <C-W>gF

" use 'Y' to yank to the end of a line, instead of the whole line
nnoremap <silent> Y y$

" take first suggested spelling as correct spelling and replace
nnoremap <silent> <leader>z z=1<CR><CR>

" Create a manual fold with the region determined by going to the end of the
" line, entering visual line mode, then jumping to the matching brace. So:
"
"     const foldThisFunction = (x) => {
"       // ...
"     }
"
" cursor on first line will fold entire function definition, etc.
nnoremap <silent> <leader>zf $V%zf

" Make the fold that we're currently in the only fold showing; collapse all
" other folds. Mnemonic: "z This"
nnoremap <silent> zT zMzvzczO

" Show the stack of syntax groups under the cursor.
" Useful for debugging Vim colorschemes.
nnoremap <silent> <leader>c :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

" Easier to type on my keyboard than gt and gT
noremap <silent> gr gt
noremap <silent> gR gT

" Some <leader> mappings to cut / copy / paste with system clipboard.
noremap <silent> <leader>y "+y
noremap <silent> <leader>Y "+Y
noremap <silent> <leader>d "+d
noremap <silent> <leader>D "+D
noremap <silent> <leader>p "+p
noremap <silent> <leader>P "+P

" Ideally I'd be able to specify no <M- keybindings in insert mode. For now,
" whitelist them as they come up:
inoremap <M-k> <ESC>k
inoremap <M-j> <ESC>j
inoremap <M-Enter> <ESC>:
inoremap <M-p> <ESC>p

function! ToggleKJEsc() abort
  if empty(maparg('kj', 'i'))
    inoremap kj <ESC>
    echo 'kj enabled'
  else
    iunmap kj
    echo 'kj disabled'
  end
endfunction
nnoremap <silent> <leader>kj :call ToggleKJEsc()<CR>
call system('ioreg -p IOUSB | grep -iq ergodox')
if v:shell_error
  " Ergodox not connected, so probably using internal keyboard.
  silent! call ToggleKJEsc()
endif

" ----- Terminal features ---------------------------------------------------
" Some of these only work in Neovim.

" Open terminal in a split
command! Vte vsplit | terminal
command! Ste split | terminal

" Resize the current vertical split (either larger or smaller)
nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Keybindings to switch panes when in an embedded terminal buffer
" (Neovim-specific)
if exists(':tnoremap')
  tnoremap <M-e> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" Keybindings that make Vim behave like tmux when not inside tmux
if $TMUX ==# ''
  tnoremap <C-f>1 <C-\><C-n>1gt
  tnoremap <C-f>2 <C-\><C-n>2gt
  tnoremap <C-f>3 <C-\><C-n>3gt
  tnoremap <C-f>4 <C-\><C-n>4gt
  tnoremap <C-f>5 <C-\><C-n>5gt
  tnoremap <C-f>6 <C-\><C-n>6gt
  tnoremap <C-f>7 <C-\><C-n>7gt
  tnoremap <C-f>8 <C-\><C-n>8gt
  tnoremap <C-f>9 <C-\><C-n>9gt

  tnoremap <C-f>" <C-\><C-n>:Vte<CR>
  tnoremap <C-f>% <C-\><C-n>:Ste<CR>
  tnoremap <C-f>c <C-\><C-n>:tabe term://zsh<CR>

  " Need recursive map to pick up fzf mapping
  tmap <C-f><C-p> <C-\><C-n><C-p>
  tnoremap <C-f><CR> <C-\><C-n>:

  tmap <C-f>- <C-\><C-n><leader>-
  tmap <C-f>= <C-\><C-n><leader>=

  nnoremap <C-f>1 1gt
  nnoremap <C-f>2 2gt
  nnoremap <C-f>3 3gt
  nnoremap <C-f>4 4gt
  nnoremap <C-f>5 5gt
  nnoremap <C-f>6 6gt
  nnoremap <C-f>7 7gt
  nnoremap <C-f>8 8gt
  nnoremap <C-f>9 9gt
  nnoremap <C-f>" :Vte<CR>
  nnoremap <C-f>% :Ste<CR>
  nnoremap <C-f>c :tabe term://zsh<CR>

  nmap <C-f>- <leader>-
  nmap <C-f>= <leader>=
endif

" ----- Terminal-as-GUI settings --------------------------------------------

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

" NeoVim and iTerm2 support displaying more cursor shapes than just a block.
if $ALACRITTY_LOG
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
    \,i-ci:ver25-Cursor/lCursor
    \,r-cr:hor20-Cursor/lCursor
else
  set guicursor=n-v-c:block
    \,i-ci-ve:ver25
    \,r-cr:hor20
    \,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175
endif


" ----- Not-quite-general-but-don't-belong-anywhere-else Settings -----------

augroup vimrc
  " Clear the current autocmd group, in case we're re-sourcing the file
  au!

  " Jump to the last known cursor position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END
