
function! s:BuildComplete(job_id, err, event) abort
  if !a:err
    echom 'ghc-mod: Build complete.'
  else
    echom 'ghc-mod: Build errored. Try manually.'
  endif
endfunction

let s:version = system('stack exec --silent -- ghc-mod --version')
if v:shell_error
  call jobstart('stack build ghc-mod', {
        \ 'on_exit': function('s:BuildComplete'),
        \ })
endif

