"
" File:       ft-settings.vim
" Author:     Jake Zimmerman <jake@zimmerman.io>
" Created:    2017-08-15
"

" ----- Filetype Settings ---------------------------------------------------

augroup myFiletypes
  au!

  " Patch filetypes for common extensions

  " Markdown files
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  " Treat all .tex files as latex
  au BufRead,BufNewFile *.tex setlocal filetype=tex
  " LaTeX class files
  au BufRead,BufNewFile *.cls setlocal filetype=tex
  " Amethyst config file
  au BufRead,BufNewFile .amethyst setlocal filetype=json
  " jrnl config file
  au BufRead,BufNewFile .jrnl_config setlocal filetype=json
  " Processing Java file
  au BufRead,BufNewFile *.pde setlocal filetype=java
  " Gradle files
  au BufRead,BufNewFile *.gradle setlocal filetype=groovy
  " gitconfig files
  au BufRead,BufNewFile gitconfig setlocal filetype=gitconfig
  " JavaScript linting files
  au BufRead,BufNewFile .eslintrc setlocal filetype=json
  au BufRead,BufNewFile .jscsrc setlocal filetype=json
  " 15-411 intermediate language filetypes
  au BufRead,BufNewFile *.l1 setlocal filetype=c0
  au BufRead,BufNewFile *.l2 setlocal filetype=c0
  au BufRead,BufNewFile *.l3 setlocal filetype=c0
  au BufRead,BufNewFile *.l4 setlocal filetype=c0
  " SQLite-specific file
  au BufRead,BufNewFile *.sqlite setlocal filetype=sql
  " Ensure that *.hs files are haskell files (sometimes Stack scripts aren't)
  au BufRead,BufNewFile *.hs setlocal filetype=haskell

  " Turn on spell checking and 80-char lines by default for these filetypes
  au FileType pandoc,markdown,tex setlocal spell
  au FileType pandoc,markdown,tex setlocal tw=80

  " Always use tabs
  au FileType gitconfig setlocal noexpandtab
  au FileType go setlocal noexpandtab

  " Use coneal characters with SML
  au FileType sml setlocal conceallevel=2
  au FileType mllex setlocal conceallevel=2
  au FileType mlyacc setlocal conceallevel=2

  " Use coneal characters with LaTeX
  au FileType tex setlocal conceallevel=2

  " Reset concealcursor in Vim help
  au FileType help setlocal concealcursor=

  " Wrap long lines in quickfix windows
  au FileType qf setlocal wrap
  " Set cursorline in quickfix windows
  au FileType qf setlocal cursorline

  " Show color column in some filetypes
  au FileType haskell setlocal cc=80
  au FileType ruby setlocal cc=80
  au FileType javascript setlocal cc=80
augroup END
