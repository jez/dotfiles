" gitcommit.vim
" Author: Jake Zimmerman <jake@zimmerman.io>
"
" This is slightly modified from syntax/gitcommit.vim. Most changes are noted
" inline.

" In the original, this checks for the end of a region by matching /^$/, or an
" empty line.  My git setup strips whitespace on save, so when I save I'd
" normally lose highlighting.
syn include @gitcommitDiff syntax/diff.vim
syn region gitcommitDiff start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|#\)\@=/ fold contains=@gitcommitDiff

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
