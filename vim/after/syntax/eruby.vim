
" Use pandoc syntax highlighting inside 'md do' blocks in eruby files
syn include @pandocSyntax syntax/pandoc.vim
syn region erbPandoc start=/<% md do %>/ end=/<% end %>/ contains=@pandocSyntax keepend

