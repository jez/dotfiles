" Vim color file
" Modified from Damien Gombault <desinteger@gmail.com> monokai.vim
" Maintainer:  Jacob Zimmerman <z1mm32m4n@gmail.com>
" WWW:         
" Last Change: 10 Oct 2013
" Version:     1.0.0
" Liscense:
"     This program is free software: you can redistribute it and/or modify
"     it under the terms of the GNU General Public License as published by
"     the Free Software Foundation, either version 3 of the License, or
"     (at your option) any later version.
"     
"     This program is distributed in the hope that it will be useful,
"     but WITHOUT ANY WARRANTY; without even the implied warranty of
"     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"     GNU General Public License for more details.

"     You should have received a copy of the GNU General Public License
"     along with this program.  If not, see <http://www.gnu.org/licenses/>.

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "pastel"

set t_Co=256

"hi Normal       ctermfg=255 ctermbg=235
hi Normal       ctermfg=254 ctermbg=000

" Main highlight groups
hi Cursor       ctermbg=fg
"hi CursorIM
"hi CursorColumn
hi CursorLine   ctermbg=237
hi Directory    ctermfg=081 cterm=none
hi DiffAdd      ctermfg=bg ctermbg=112
hi DiffChange   ctermfg=bg ctermbg=222
hi DiffDelete   ctermfg=bg ctermbg=198
hi DiffText     ctermfg=bg ctermbg=222
hi ErrorMsg     ctermfg=198 ctermbg=bg cterm=none
hi VertSplit    ctermfg=237 ctermbg=bg cterm=none
hi Folded       ctermfg=243ctermbg=bg cterm=none
hi FoldColumn   ctermfg=243 ctermbg=237 cterm=none
hi SignColum    ctermfg=243 ctermbg=237 cterm=none
hi IncSearch    ctermfg=bg ctermbg=222 cterm=none
hi LineNr       ctermfg=240 ctermbg=000 cterm=none
hi MatchParen   ctermfg=081 ctermbg=bg cterm=bold
hi ModeMsg      cterm=none
hi MoreMsg      ctermfg=081 cterm=none
hi NonText      ctermfg=237 cterm=none
hi Pmenu        ctermfg=fg ctermbg=237
hi PmenuSel     ctermfg=fg ctermbg=bg
hi PmenuSbar    ctermbg=bg
hi PmenuThumb   ctermfg=fg
hi Question     ctermfg=112 cterm=none
hi Search       ctermfg=bg ctermbg=222 cterm=none
hi SpecialKey   ctermfg=237 cterm=none
hi SpellBad     cterm=underline
hi SpellCap     guisp=#65D9EF
"hi SpellLocal
hi SpellRare    guisp=#AE81FF
hi StatusLine   ctermfg=fg ctermbg=237 cterm=none
hi StatusLineNC ctermfg=243 ctermbg=237 cterm=none
hi TabLine      ctermfg=fg ctermbg=236 cterm=none
hi TabLineFill  ctermfg=fg ctermbg=236 cterm=none
hi TabLineSel   ctermfg=081 ctermbg=000 cterm=underline
hi Title        ctermfg=198 cterm=none
hi Visual       ctermbg=238 cterm=none
"hi VisualNOS
hi WarningMsg   ctermfg=198 cterm=none
"hi WildMenu

"hi Menu
"hi ScrollBar
"hi Tooltip


" Plugin specific highlight groups
hi MyTagListFileName ctermfg=208 ctermbg=bg cterm=none


" Color groups
hi Blue    ctermfg=081 cterm=none
hi Green   ctermfg=112 cterm=none
hi Grey    ctermfg=243 cterm=none
hi Orange  ctermfg=208 cterm=none
hi Purple  ctermfg=141 cterm=none
hi Red     ctermfg=198 cterm=none
hi White   ctermfg=255 cterm=none
hi Yellow  ctermfg=222 cterm=none

hi RedU    ctermfg=198 cterm=underline,italic
hi BlueU   ctermfg=081 cterm=underline

hi GreyI   ctermfg=243 cterm=italic

hi RedR    ctermfg=fg ctermbg=198 cterm=none
hi YellowR ctermfg=bg ctermbg=208 cterm=italic


" Syntax highligh groups
hi! link Comment      GreyI
"
hi! link Constant     Purple
hi! link String       Yellow
hi! link Character    Yellow
"hi Number
"hi Boolean
"hi Float
"
hi! link Identifier   Green
"hi Function
"
hi! link Statement    Red
"hi Conditional
"hi Repeat
"hi Label
hi! link Operator     Green
"hi Keyword
"hi Exception
"
hi! link PreProc      Orange
"hi Include
"hi Define
"hi Macro
"hi PreCondit
"
hi! link Type         Blue
hi! link StorageClass Red
"hi Structure
"hi Typedef
"
hi! link Special      Grey
"hi SpecialChar
hi! link Tag          Green
"hi Delimiter
"hi SpecialComment
"hi Debug
"
hi! link Underlined   BlueU
"hi Ignore
hi! link Error        RedR
hi! link Todo         YellowR

" Language specific highligh groups
" C
hi link cStatement              Green
hi link Note                    RedU
hi link cCommentGroup           GreyI
" C++
hi link cppStatement            Green
" CSS
hi link cssBraces               White
hi link cssFontProp             White
hi link cssColorProp            White
hi link cssTextProp             White
hi link cssBoxProp              White
hi link cssRenderProp           White
hi link cssAuralProp            White
hi link cssRenderProp           White
hi link cssGeneratedContentProp White
hi link cssPagingProp           White
hi link cssTableProp            White
hi link cssUIProp               White
hi link cssFontDescriptorProp   White
" Java
hi link javaStatement           Green
" Python
hi link pyNote                  RedU
hi link pyCommentGroup          GreyI
" Ruby
hi link rubyClassVariable       White
hi link rubyControl             Green
hi link rubyGlobalVariable      White
hi link rubyInstanceVariable    White
