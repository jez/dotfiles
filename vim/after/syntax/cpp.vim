syn match cppNamespacedConstant /::\zs[A-Z]\w*/
syn match cppNamespace /\<\w\+\(::\)\@=/
syn match cppNamespacedType /::\zs[A-Z]\w*\ze[ >]/

hi def link cppNamespace Include
hi def link cppNamespacedConstant Identifier
hi def link cppNamespacedType Type
