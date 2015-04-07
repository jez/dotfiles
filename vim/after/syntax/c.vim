"syn keyword cStatement      malloc calloc xmalloc xcalloc free main printf fprintf realloc
" Not quite sure why this has to be here... somehow it's getting overwritten
syn keyword cTodo           contained TODO FIXME XXX
syn keyword Note            NOTE Note note
syn cluster cCommentGroup   contains=cTodo,Note

hi def link cAssert		     PreProc
hi def link cTodo          Todo
