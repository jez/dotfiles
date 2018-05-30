
" We don't use indented code blocks in pay-server.
" But sometimes we do indent the Markdown within `<% md do %>` blocks.
" So we use this convenient setting to disable highlighting those blocks.
let g:pandoc#syntax#protect#codeblocks = 0

" Use pandoc syntax highlighting inside 'md do' blocks in eruby files
syn include @pandocSyntax syntax/pandoc.vim
syn region erbPandoc start=/<% md do %>/ end=/<% end %>/ contains=@pandocSyntax keepend

