" gitcommit.vim
" Author: Jake Zimmerman <jake@zimmerman.io>
"
" This is slightly modified from syntax/gitcommit.vim. Most changes are noted
" inline.

" Try to guess the current comment character (not perfect)
" The alternative is to hard code '#' as the comment character
function! s:getCommentChar()
  let line = getline(search('^..Please enter the commit message', 'nw'))
  if strlen(line) > 0
    return line[0]
  endif
endfunction

let s:commentChar = s:getCommentChar()

syn clear gitcommitComment
exe "syn match gitcommitComment '^" .s:commentChar .".*'"
