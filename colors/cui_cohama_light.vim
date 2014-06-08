set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "cui_cohama_light"

" base
hi Normal          ctermfg=239  ctermbg=231

" programming literals
hi Comment         ctermfg=113
hi Constant        ctermfg=105               cterm=bold
hi String          ctermfg=172
hi Character       ctermfg=166
hi Number          ctermfg=204
hi Boolean         ctermfg=204
hi Float           ctermfg=204

" programming statements
hi Identifier      ctermfg=88               cterm=none
hi Function        ctermfg=19
hi Statement       ctermfg=207
hi Conditional     ctermfg=209
hi Repeat          ctermfg=209
hi Label           ctermfg=158
hi Operator        ctermfg=232
hi Keyword         ctermfg=199
hi Exception       ctermfg=217

" programming pre-processes
hi PreProc         ctermfg=39
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc

" programming types
hi Type            ctermfg=57
hi StorageClass    ctermfg=57
hi Structure       ctermfg=26
hi Typedef         ctermfg=26

" specials
hi Special         ctermfg=69
hi Delimiter       ctermfg=232
hi SpecialComment  ctermfg=245               cterm=bold
hi Debug           ctermfg=219               cterm=bold
hi SpecialKey      ctermfg=61

" vim views
hi Cursor          ctermfg=16   ctermbg=253
hi CursorIM        ctermfg=16   ctermbg=124
hi CursorLine                   ctermbg=230  cterm=none
hi CursorColumn                 ctermbg=195
hi ColorColumn                  ctermbg=230
hi LineNr          ctermfg=244  ctermbg=255
hi CursorLineNr    ctermfg=16   ctermbg=226  cterm=bold
hi FoldColumn      ctermfg=250  ctermbg=255
hi SignColumn                   ctermbg=234
hi Folded          ctermfg=109  ctermbg=255
hi Search                       ctermbg=225  cterm=underline
hi IncSearch       ctermfg=14   ctermbg=209  cterm=NONE
hi NonText         ctermfg=253  ctermbg=15
hi StatusLine      ctermfg=27  ctermbg=117  cterm=bold
hi StatusLineNC    ctermfg=242   ctermbg=252  cterm=NONE
hi Todo            ctermfg=33   ctermbg=NONE cterm=bold
hi TabLine         ctermfg=238   ctermbg=248  cterm=NONE
hi TabLineSel      ctermfg=232  ctermbg=231   cterm=bold
hi TabLineFill     ctermfg=245  ctermbg=245
hi Title           ctermfg=170

" diffs
hi DiffAdd                      ctermbg=17
hi DiffChange      ctermfg=181  ctermbg=236
hi DiffDelete      ctermfg=162  ctermbg=53
hi DiffText                     ctermbg=239  cterm=bold

" complete menus
hi Pmenu           ctermfg=NONE ctermbg=195
hi PmenuSel        ctermfg=NONE ctermbg=51
hi PmenuSbar                    ctermbg=153
hi PmenuThumb      ctermbg=39

" errors
hi Error           ctermfg=88   ctermbg=225
hi ErrorMsg        ctermfg=196  ctermbg=225  cterm=bold
hi SpellBad        ctermbg=225
hi SpellCap        ctermbg=200
hi SpellLocal      ctermbg=200
hi SpellRare       ctermbg=200

" others
hi Directory       ctermfg=70                cterm=bold
hi Ignore          ctermfg=244  ctermbg=232
hi MatchParen      ctermfg=53   ctermbg=153  cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Question        ctermfg=110
hi Underlined      ctermfg=244               cterm=underline
hi VertSplit       ctermfg=244  ctermbg=232  cterm=bold
hi Visual                       ctermbg=159
hi VisualNOS       ctermfg=255  ctermbg=33
hi WarningMsg      ctermfg=231  ctermbg=238   cterm=bold
hi WildMenu        ctermfg=110  ctermbg=16

" vim: set colorcolumn=20,33,46 :
