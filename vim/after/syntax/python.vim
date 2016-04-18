syn region pythonDocstring
      \ start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl
      \ contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syn region pythonDocstring
      \ start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl
      \ contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

hi def link pythonDocstring Comment
