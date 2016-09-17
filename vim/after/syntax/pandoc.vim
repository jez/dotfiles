" Highlight liquid highlight blocks
syn region pandocDelimitedCodeBlock start=/^\(>\s\)\?\z(\(\s\{4,}\)\={%\s*highlight \w\+\s*%}\)/ end=/^{%\s*endhighlight\s*%}/ skipnl contains=pandocDelimitedCodeBlockStart,pandocDelimitedCodeBlockEnd keepend

