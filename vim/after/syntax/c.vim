syn keyword cType           bitarray queue ht stack pixel ht_elem ht_key queue_elem c0_value ubyte byte function_info bc0_file native_info c0_array_header frame native_fn c0_array
syn keyword cConstant       BITARRAY_LIMIT 
syn keyword cConstant       IADD IAND IDIV IMUL IOR IREM ISHL ISHR ISUB IXOR DUP POP SWAP NEWARRAY ARRAYLENGTH NEW AADDF AADDS IMLOAD AMLOAD IMSTORE AMSTORE CMLOAD CMSTORE VLOAD VSTORE ACONST_NULL BIPUSH ILDC ALDC NOP IF_CMPEQ IF_CMPNE IF_ICMPLT IF_ICMPGE IF_ICMPGT IF_ICMPLE GOTO ATHROW ASSERT INVOKESTATIC INVOKENATIVE RETURN 
syn keyword cStatement      malloc calloc xmalloc xcalloc free main printf fprintf realloc
syn keyword cAssert         assert REQUIRES ENSURES ASSERT INT VAL
" Not quite sure why this has to be here... somehow it's getting overwritten
syn keyword cTodo           contained TODO FIXME XXX
syn keyword Note            NOTE Note note
syn cluster cCommentGroup   contains=cTodo,Note

hi def link cAssert		     PreProc
hi def link cTodo          Todo
