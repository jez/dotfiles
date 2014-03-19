syn keyword Constant        None True False
" Not quite sure why this has to be here... somehow it's getting overwritten
syn keyword pyTodo          contained TODO FIXME XXX
syn keyword pyNote          NOTE Note note
syn cluster pyCommentGroup  contains=pyTodo,pyNote

hi def link pyTodo          Todo
