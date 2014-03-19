" Vim syntax file
" Language:     Setty	
" Maintainer:	Adam Blank <adamblan@cs.cmu.edu>
" Last Change:	2013 Jun 17 
" Credits:	This is based on setty.vim by
"		  Zvezdan Petkovic <zpetkovic@acm.org>
"		  Neil Schemenauer <nas@setty.ca>
"		  Dmitry Vasiliev
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Keep setty keywords in alphabetical order inside groups for easy
" comparison with the table in the 'setty Language Reference'
"
syn keyword settyStatement	T, F
syn keyword settyStatement	print printx
syn keyword settyStatement	return requires recurse
syn keyword settyConditional	else if
syn keyword settyRepeat	        for
syn keyword settyOperator	and in not or union intersect minus
syn keyword settyInclude        use	

" The zero-length non-grouping match before the function name is
" extremely important in settyFunction.  Without it, everything is
" interpreted as a function inside the contained environment of
" doctests.
syn match   settyFunction
      \ "\%(\%(def\s\|class\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained

syn match   settyComment	"#.*$" contains=settyTodo,@Spell
syn keyword settyTodo		FIXME NOTE NOTES TODO XXX contained

" Triple-quoted strings can contain doctests.
syn region  settyString
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=settyEscape,@Spell
syn region  settyString
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=settyEscape,settySpaceError,settyDoctest,@Spell
syn region  settyRawString
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
syn region  settyRawString
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
      \ contains=settySpaceError,settyDoctest,@Spell

syn match   settyEscape	+\\[abfnrtv'"\\]+ contained
syn match   settyEscape	"\\\o\{1,3}" contained
syn match   settyEscape	"\\x\x\{2}" contained
syn match   settyEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" setty allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   settyEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   settyEscape	"\\$"

if exists("setty_highlight_all")
  if exists("setty_no_builtin_highlight")
    unlet setty_no_builtin_highlight
  endif
  if exists("setty_no_number_highlight")
    unlet setty_no_number_highlight
  endif
  let setty_space_error_highlight = 1
endif

" It is very important to understand all details before changing the
" regular expressions below or their order.
" The word boundaries are *not* the floating-point number boundaries
" because of a possible leading or trailing decimal point.
" The expressions below ensure that all valid number literals are
" highlighted, and invalid number literals are not.  For example,
"
" - a decimal point in '4.' at the end of a line is highlighted,
" - a second dot in 1.0.0 is not highlighted,
" - 08 is not highlighted,
" - 08e0 or 08j are highlighted,
"
" and so on, as specified in the 'setty Language Reference'.
if !exists("setty_no_number_highlight")
  " numbers (including longs and complex)
  syn match   settyNumber	"\<\%([1-9]\d*\|0\)\=\>"
endif

" Group the built-ins in the order in the 'setty Library Reference' for
" easier comparison.
" http://docs.setty.org/library/constants.html
" http://docs.setty.org/library/functions.html
" http://docs.setty.org/library/functions.html#non-essential-built-in-functions
" setty built-in functions are in alphabetical order.
if !exists("setty_no_builtin_highlight")
  " built-in constants
  syn keyword settyBuiltin	F T
  " built-in functions
  syn keyword settyBuiltin	pi1 pi2 cardinality lt leq gt geq implies iff unimplemented
endif

if exists("setty_space_error_highlight")
  " trailing whitespace
  syn match   settySpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   settySpaceError	display " \+\t"
  syn match   settySpaceError	display "\t\+ "
endif

if version >= 508 || !exists("did_setty_syn_inits")
  if version <= 508
    let did_setty_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlight links.  Can be overridden later.
  HiLink settyStatement	Statement
  HiLink settyConditional	Conditional
  HiLink settyRepeat		Repeat
  HiLink settyOperator		Operator
  HiLink settyInclude		Include
  HiLink settyDecorator	Define
  HiLink settyFunction		Function
  HiLink settyComment		Comment
  HiLink settyTodo		Todo
  HiLink settyString		String
  HiLink settyRawString	String
  HiLink settyEscape		Special
  if !exists("setty_no_number_highlight")
    HiLink settyNumber		Number
  endif
  if !exists("setty_no_builtin_highlight")
    HiLink settyBuiltin	Function
  endif
  if exists("setty_space_error_highlight")
    HiLink settySpaceError	Error
  endif
  if !exists("setty_no_doctest_highlight")
    HiLink settyDoctest	Special
    HiLink settyDoctestValue	Define
  endif

  delcommand HiLink
endif

let b:current_syntax = "setty"

" vim:set sw=2 sts=2 ts=8 noet:
