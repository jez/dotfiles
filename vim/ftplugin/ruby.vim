
" TODO(jez) Can land this in vim-sorbet once LanguageClient_hoverMarginSize is
" a real option.
"
" https://github.com/autozimu/LanguageClient-neovim/pull/1111
function! LanguageClientPandocMarkdown()
  if bufname('%') ==# '__LanguageClient__'
    setlocal filetype=pandoc
  endif
endfunction

if exists('g:vim_pandoc_syntax_exists')
  let g:LanguageClient_hoverMarginSize = 0
  augroup vimSorbetPandocMarkdown
    au!
    au FileType markdown call LanguageClientPandocMarkdown()
  augroup END
endif
