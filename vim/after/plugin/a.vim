" Name: Overrides for a.vim plugin
" Author: Jake Zimmerman
" Created: Mon Dec 28 03:14:18 CST 2015
" License: MIT License

" a.vim binds some Leader mappings in insert mode, making Vim have a delay
" (of duration 'timeoutlen') everytime '\' is typed. This is excessively
" annoying when writing LaTeX.
"
" You can't rebind mappings until after the plugin has made them, and the
" vimrc loads first, so they have to go here.
iunmap <Leader>ih
iunmap <Leader>is
iunmap <Leader>ihn
