set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "gui_cohama"

" base
hi Normal          guifg=#9E9EB5 guibg=#121230 gui=NONE

" programming literals
hi Comment         guifg=#4A4A6B               gui=italic
hi Constant        guifg=#6D86CF               gui=bold
hi String          guifg=#B07558
hi Character       guifg=#C9773C
hi Number          guifg=#C25367
hi Boolean         guifg=#C4475D
hi Float           guifg=#C4475D

" programming statements
hi Identifier      guifg=#BFAB86               gui=NONE
hi Function        guifg=#78C49C               gui=NONE
hi Statement       guifg=#E0A4CE               gui=NONE
hi Conditional     guifg=#DFE3B3               gui=NONE
hi Repeat          guifg=#DFE3B3               gui=NONE
hi Label           guifg=#C1E3B3               gui=NONE
hi Operator        guifg=#EBEAB2               gui=NONE
hi Keyword         guifg=#E897CF               gui=NONE
hi Exception       guifg=#DFE3B3               gui=NONE

" programming pre-processes
hi PreProc         guifg=#61ABC2               gui=NONE
hi Include         guifg=#61ABC2
hi Define          guifg=#61ABC2
hi Macro           guifg=#61ABC2
hi PreCondit       guifg=#61ABC2

" programming types
hi Type            guifg=#9BBCCC               gui=NONE
hi StorageClass    guifg=#9BBCCC
hi Structure       guifg=#6392FF
hi Typedef         guifg=#9BBCCC

" specials
hi Special         guifg=#6F91F7
hi Delimiter       guifg=#FAF9F7
hi SpecialComment  guifg=#6767A8               gui=italic
hi Debug           guifg=#C0C0C0
hi SpecialKey      guifg=#595996               gui=NONE

" vim views
hi Cursor          guifg=#040410 guibg=#D1CCDE
hi CursorIM        guifg=#040410 guibg=#A08ADB
hi CursorLine                    guibg=#181845 gui=NONE
hi CursorColumn                  guibg=#181845 gui=NONE
hi ColorColumn                   guibg=#183645
hi Conceal         guifg=#80809C
hi LineNr          guifg=#80809C guibg=#080820
hi CursorLineNr    guifg=#E6E229 guibg=#13132A
hi FoldColumn      guifg=#80809C guibg=#36364D
hi SignColumn      guifg=NONE    guibg=#121230
hi Folded          guifg=#7F7FB5 guibg=#333342
hi Search          guifg=#DCDCF5 guibg=#2F919E gui=underline
hi IncSearch       guifg=#000000 guibg=#9C9C11 gui=underline
hi NonText         guifg=#393980 guibg=#0F0F29
hi StatusLine      guifg=#0D0DB5 guibg=#DEDEFA gui=bold
hi StatusLineNC    guifg=#5D5DBA guibg=#1E1E45 gui=NONE
hi Todo            guifg=#9B9CB0 guibg=NONE    gui=bold
hi TabLine         guifg=#9B9CB0 guibg=#36364D gui=NONE
hi TabLineSel      guifg=#DEDEFA guibg=#0F0F29 gui=bold
hi TabLineFill     guifg=#9B9CB0 guibg=#9B9CB0
hi Title           guifg=#C7C561               gui=bold

" diffs
hi DiffAdd         guifg=NONE    guibg=#000050
hi DiffDelete      guifg=#610020 guibg=#380013
hi DiffChange      guifg=NONE    guibg=#2F0045
hi DiffText        guifg=NONE    guibg=#6C009E gui=bold,underline

" complete menus
hi Pmenu           guifg=NONE    guibg=#36364D gui=NONE
hi PmenuSel        guifg=#FFFFFF guibg=#6B6B96 gui=bold
hi PmenuSbar                     guibg=#444496
hi PmenuThumb                    guibg=#5959C2

" errors
hi Error           guifg=NONE    guibg=#0F0F29 gui=undercurl guisp=#E32935
hi ErrorMsg        guifg=#E32935 guibg=NONE
hi SpellBad                                    gui=undercurl guisp=#AB06CC
hi SpellCap                                    gui=undercurl guisp=#765FC7
hi SpellLocal                                  gui=undercurl guisp=#765FC7
hi SpellRare                                   gui=undercurl guisp=#765FC7

" others
hi Directory       guifg=#0DBA5F               gui=bold
hi Ignore          guifg=#1A1A38 guibg=NONE
hi MatchParen      guifg=NONE    guibg=#571C5E gui=bold
hi ModeMsg         guifg=#235E1C               gui=italic
hi MoreMsg         guifg=#5B7573               gui=NONE
hi Question        guifg=#3A3A85
hi Underlined      guifg=#D5D6EB               gui=underline
hi VertSplit       guifg=#2A2A75 guibg=#02021A gui=bold
hi Visual          guifg=NONE    guibg=#2F2F52
hi VisualNOS       guifg=NONE    guibg=#2F2F52
hi WarningMsg      guifg=#969035 guibg=NONE
hi WildMenu        guifg=#DEDEFA guibg=#5858A3 gui=bold

" vim: set colorcolumn=20,34,48 :
