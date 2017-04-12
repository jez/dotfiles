let texMathList=[
  \ ['blacktriangleright', '▶'],
  \ ['vartriangleright',   '▷'],
  \ ['_',                  '_'],
  \ ['{',                  '{'],
  \ ['}',                  '}'],
  \ ['\\',                 '↵'],
  \ ['iff',                '⇔'],
  \ ['implies',            '⇒'],
  \ ['leftrightarrow',     '↔'],
  \ ['longleftrightarrow', '↔'],
  \ ['patheq',             '↔'],
  \ ['whnorm',             '⇓'],
  \ ['whred',              '↝'],
  \ ['synth',              '⇒'],
  \ ['check',              '⇐'],
  \ ['langle',             '〈'],
  \ ['rangle',             '〉'],
  \ ['pto',                '→'],
  \ ]
for texmath in texMathList
  if texmath[0] =~# '\w$'
    exe "syn match texMathSymbol '\\\\".texmath[0]."\\>' contained conceal cchar=".texmath[1]
  else
    exe "syn match texMathSymbol '\\\\".texmath[0]."' contained conceal cchar=".texmath[1]
  endif
endfor

syn match texMathSymbol '\\,' contained conceal
syn match texMathSymbol '\\quad' contained conceal

fun! SuperSub(group,leader,pat,cchar)
  exe 'syn match '.a:group." '".a:leader.a:pat."' contained conceal cchar=".a:cchar
  exe 'syn match '.a:group."s '".a:pat        ."' contained conceal cchar=".a:cchar.' nextgroup='.a:group.'s'
endfun

call SuperSub('texSubscript', '_', 'h', 'ₕ')
call SuperSub('texSubscript', '_', 'k', 'ₖ')
call SuperSub('texSubscript', '_', 'l', 'ₗ')
call SuperSub('texSubscript', '_', 'm', 'ₘ')
call SuperSub('texSubscript', '_', 'n', 'ₙ')
call SuperSub('texSubscript', '_', 'p', 'ₚ')
call SuperSub('texSubscript', '_', 's', 'ₛ')
call SuperSub('texSubscript', '_', 't', 'ₜ')

call TexNewMathZone("M","mathpar",1)

