" Vim color file
" Modified from darkblue.vim
" @author Adam Blank 

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "euler"

hi Normal       guifg=#c0c0c0 guibg=#000040                     ctermfg=lightgray ctermbg=black
"hi ErrorMsg     guifg=#ffffff guibg=#287eff                     ctermfg=white ctermbg=lightblue
highlight ErrorMsg      guifg=LightYellow  guibg=FireBrick
hi Visual       guifg=#8080ff guibg=fg      gui=reverse              ctermbg=235
"hi VisualNOS    guifg=#8080ff guibg=fg      gui=reverse,underline   ctermfg=bg ctermbg=fg cterm=reverse,underline
hi Todo         guifg=#d14a14 guibg=#1248d1                     ctermfg=red ctermbg=darkblue
hi Search       guifg=#90fff0 guibg=#2050d0                     ctermfg=white ctermbg=darkblue cterm=underline term=underline
hi IncSearch    guifg=#b0ffff guibg=#2050d0                         ctermfg=darkblue ctermbg=gray

hi SpecialKey       guifg=cyan          ctermfg=darkcyan
hi Directory        guifg=cyan          ctermfg=cyan
hi Title            guifg=magenta gui=none ctermfg=magenta cterm=bold
hi WarningMsg       guifg=red           ctermfg=red
hi WildMenu         guifg=yellow guibg=black ctermfg=yellow ctermbg=black cterm=none term=none
hi ModeMsg          guifg=#22cce2       ctermfg=white
hi MoreMsg          ctermfg=darkgreen   ctermfg=darkgreen
hi Question         guifg=green gui=none ctermfg=green cterm=none
hi NonText          guifg=#0030ff       ctermfg=darkblue


"hi StatusLine   guifg=blue guibg=darkgray gui=none      ctermfg=blue ctermbg=gray term=none cterm=none
highlight StatusLine    ctermfg=17 ctermbg=gray
hi VertSplit    guifg=black guibg=darkgray gui=none     ctermfg=black ctermbg=gray term=none cterm=none

hi Folded   guifg=#808080 guibg=#000040         ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi FoldColumn   guifg=#808080 guibg=#000040         ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi LineNr   guifg=#90f020           ctermfg=221 cterm=none

hi DiffAdd  guibg=darkblue  ctermbg=darkblue term=none cterm=none
hi DiffChange   guibg=darkmagenta ctermbg=magenta cterm=none
hi DiffDelete   ctermfg=blue ctermbg=cyan gui=bold guifg=Blue guibg=DarkCyan
hi DiffText cterm=bold ctermbg=red gui=bold guibg=Red

hi Cursor   guifg=black guibg=yellow ctermfg=black ctermbg=yellow
hi lCursor  guifg=black guibg=white ctermfg=black ctermbg=white


hi Comment  ctermfg=239 guifg=#80a0ff
hi Constant ctermfg=107 guifg=#ffa0a0 cterm=none
hi Special  ctermfg=107 guifg=Orange cterm=none gui=none
hi Identifier   ctermfg=107 guifg=#40ffff cterm=none
hi Statement    ctermfg=66 cterm=none guifg=#ffff60 gui=none
hi PreProc  ctermfg=107 guifg=#ff80ff gui=none cterm=none
hi type     ctermfg=25 guifg=#60ff60 gui=none cterm=none
hi Underlined   cterm=underline term=underline
hi Ignore   guifg=bg ctermfg=bg

" suggested by tigmoid, 2008 Jul 18
hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0
