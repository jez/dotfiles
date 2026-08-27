set runtimepath+=/usr/local/opt/fzf
set runtimepath+=/opt/homebrew/opt/fzf

augroup stripeTodo
  autocmd!
  au BufRead,BufNewFile stripe-todo.md setlocal textwidth=0
  autocmd BufReadPost stripe-todo.md 1,2fold
  autocmd BufReadPost stripe-todo.md setlocal updatetime=5000
  autocmd CursorHold,CursorHoldI stripe-todo.md if &modified && expand('%') != ''
    \ | silent! write
    \ | echom '[autosaved] ' .. expand('%:t') .. ' at ' .. strftime('%-I:%M:%S %p')
    \ | endif
augroup END
