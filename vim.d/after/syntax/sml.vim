syn keyword  smlTodo contained TODO NOTE Note FIXME XXX

" let
syn region   smlEnd matchgroup=smlStatement start="\<let\>" matchgroup=smlKeyword end="\<end\>" contains=ALLBUT,@smlContained,smlEndErr

" local
syn region   smlEnd matchgroup=smlStatement start="\<local\>" matchgroup=smlKeyword end="\<end\>" contains=ALLBUT,@smlContained,smlEndErr

" abstype
syn region   smlNone matchgroup=smlStatement start="\<abstype\>" matchgroup=smlKeyword end="\<end\>" contains=ALLBUT,@smlContained,smlEndErr

" begin
syn region   smlEnd matchgroup=smlStatement start="\<begin\>" matchgroup=smlKeyword end="\<end\>" contains=ALLBUT,@smlContained,smlEndErr

" if
syn region   smlNone matchgroup=smlStatement start="\<if\>" matchgroup=smlKeyword end="\<then\>" contains=ALLBUT,@smlContained,smlThenErr

syn keyword smlKeyword   raise exception handle infix infixl infixr match type 
syn keyword smlFunction  fn fun
syn keyword smlStatement case of while with withtype val in where
syn keyword smlOperator  and or not andalso orelse div mod quot rem
syn keyword smlTypedef   datatype
syn keyword smlType      bool char exn int list option real string unit eqtype

syn match   smlOperator  "=>"

" Super hacky because why not
hi def link smlKeyword    StorageClass
hi def link smlFunction   Function
hi def link smlStatement  Statement
hi link smlOperator   Operator
hi def link smlTypedef    Typedef
hi def link smlType       Type
