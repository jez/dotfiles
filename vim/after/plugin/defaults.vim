" Neovim set up a bunch of `gr`-prefixed LSP mappings:
" https://github.com/neovim/neovim/commit/2c6b6358722b2df9160c3739b0cea07e8779513f
" They interfere with my `gr` keybinding.
silent! unmap <silent> gri
silent! unmap <silent> grr
silent! unmap <silent> gra
silent! unmap <silent> grn
silent! unmap <silent> grt

