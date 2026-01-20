"
" File:      init.vim
" Author:    <jake@zimmerman.io>
" Created:   2017-08-15
"

" General 'set xyz', 'command', and 'map' settings
source $HOME/.vim/settings.vim

" Digraphs (separate file because syntax highlighting breaks...)
source $HOME/.vim/digraphs.vim

" Filetype-specific settings (registering and using filetypes)
source $HOME/.vim/ft-settings.vim

" Everything else: plugin settings.
source $HOME/.vim/plug-settings.vim

if has('nvim')
  source $HOME/.vim/lsp.lua
endif

" Host-specific settings (different by platform, using rcm)
" (silence error, because might not be a host-specific file)
silent! source $HOME/.util/host.vim
