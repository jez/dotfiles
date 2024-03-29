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
  au BufRead,BufNewFile,BufFilePre,BufFilePost *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md setlocal filetype=pandoc
  " Treat all .tex files as latex
  au BufRead,BufNewFile *.tex setlocal filetype=tex
  " LaTeX class files
  au BufRead,BufNewFile *.cls setlocal filetype=tex
  " Amethyst config file
  au BufRead,BufNewFile .amethyst setlocal filetype=json
  " jrnl config file
  au BufRead,BufNewFile .jrnl_config setlocal filetype=json
  au BufRead,BufNewFile jrnl setlocal filetype=json
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
  " EJS files are really just html
  au BufRead,BufNewFile *.ejs setlocal filetype=html
  " rbi files (ruby interfaces) are valid ruby
  au BufRead,BufNewFile *.rbi setlocal filetype=ruby
  " .cfg.exp files are valid dot files
  au BufRead,BufNewFile *.cfg.exp setlocal filetype=dot
  " *.BUILD files are Bazel build files
  au BufRead,BufNewFile *.BUILD setlocal filetype=bzl
  " *.ypp files are bison / yacc
  au BufRead,BufNewFile *.ypp setlocal filetype=yacc
  " *.rl files are ragel files
  au BufRead,BufNewFile *.rl setlocal filetype=ragel

  " Turn on spell checking and 80-char lines by default for these filetypes
  au FileType pandoc,pandoc.ghpull,markdown,tex setlocal spell
  au FileType pandoc,pandoc.ghpull,markdown,tex setlocal tw=80

  " Cargo-culted from here: https://github.com/vim-pandoc/vim-pandoc/blob/0d4b68eb7f63e43f963a119d60a3e29c2bb822e0/ftplugin/pandoc.vim#L51-L52
  " (not using that plugin because it's slow and opinionated otherwise)
  au FileType pandoc,pandoc.ghpull,markdown setlocal formatlistpat=\\C^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*>]\\s\\+
  au FileType pandoc,pandoc.ghpull,markdown setlocal formatoptions+=n
  au FileType pandoc,pandoc.ghpull,markdown let b:surround_indent = 0

  " Only make these aliases work in markdown files, where we expect to have
  " long wrapped lines. Don't make them work in code files, where a wrapped
  " line is rare and only happens when we have a viewport that's too narrow.
  au FileType pandoc,pandoc.ghpull,markdown noremap <silent> 0 g0
  au FileType pandoc,pandoc.ghpull,markdown noremap <silent> g0 0
  au FileType pandoc,pandoc.ghpull,markdown noremap <silent> $ g$
  au FileType pandoc,pandoc.ghpull,markdown noremap <silent> g$ $

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
  au FileType cpp setlocal cc=120
  au FileType cpp setlocal tw=100 " but shorten wrapped comments a bit.
  au FileType sh setlocal cc=80
  au FileType scala setlocal cc=80

  " Fix up some commentstrings
  au FileType c setlocal commentstring=//%s
  au FileType cpp setlocal commentstring=//%s
  au FileType yacc setlocal commentstring=//%s
  au FileType json setlocal commentstring=//%s

  " Change indentation level in some languages
  " TODO(jez) This should be in .editorconfig at some point
  au FileType c,cpp,bzl setlocal tabstop=8
  au FileType c,cpp,bzl setlocal softtabstop=4
  au FileType c,cpp,bzl setlocal shiftwidth=4

  au FileType go setlocal tabstop=8
  au FileType go setlocal shiftwidth=8

  " Add comment character when pressing 'o' or Enter
  au FileType sh setlocal formatoptions+=ro

  if has('##TermOpen')
    au TermOpen * setlocal nonumber
    au TermOpen * startinsert
  endif
  if has('##TermClose')
    " Auto-close terminal buffer when it ends
    au TermClose * q
  endif

  " scrolloff can only be set globally
  au BufEnter term://* set scrolloff=0
  au BufLeave term://* set scrolloff=4

  " Always show sign column in Ruby files so that screen doesn't bounce around
  au FileType ruby setlocal signcolumn=yes
augroup END
