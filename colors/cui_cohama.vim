" Vim color file
"   based on molokai

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="cui_cohama"

hi Normal          ctermfg=247 ctermbg=233
hi CursorLine                  ctermbg=235 cterm=none
hi Boolean         ctermfg=140
hi Character       ctermfg=144
hi Number          ctermfg=213
hi String          ctermfg=167
hi Conditional     ctermfg=198               cterm=none
hi Constant        ctermfg=140               cterm=bold
hi Cursor          ctermfg=16  ctermbg=253
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=111               cterm=bold
hi Delimiter       ctermfg=255

hi DiffAdd                     ctermbg=17
hi DiffChange      ctermfg=181 ctermbg=236
hi DiffDelete      ctermfg=162 ctermbg=53
hi DiffText                    ctermbg=239 cterm=bold

hi Directory       ctermfg=76               cterm=bold
hi Error           ctermfg=219 ctermbg=89
hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
hi Exception       ctermfg=76               cterm=bold
hi Float           ctermfg=140
hi FoldColumn      ctermfg=67  ctermbg=16
hi Folded          ctermfg=67  ctermbg=16
hi Function        ctermfg=76
hi Identifier      ctermfg=215 cterm=none
hi Ignore          ctermfg=244 ctermbg=232
hi IncSearch       ctermfg=193 ctermbg=16

hi Keyword         ctermfg=198               cterm=bold
hi Label           ctermfg=229               cterm=none
hi Macro           ctermfg=193

hi SpellBad       ctermbg=52

hi MatchParen      ctermfg=255  ctermbg=53 cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Operator        ctermfg=198

" complete menu
hi Pmenu           ctermfg=232  ctermbg=255
hi PmenuSel        ctermfg=255 ctermbg=21
hi PmenuSbar                   ctermbg=32
hi PmenuThumb      ctermfg=81

hi PreCondit       ctermfg=76               cterm=bold
hi PreProc         ctermfg=76
hi Question        ctermfg=81
hi Repeat          ctermfg=198               cterm=bold
hi Search          ctermfg=253 ctermbg=66

" marks column
hi SignColumn      ctermfg=76 ctermbg=235
hi SpecialChar     ctermfg=198               cterm=bold
hi SpecialComment  ctermfg=245               cterm=bold
hi Special         ctermfg=81
hi SpecialKey      ctermfg=0

hi Statement       ctermfg=220               cterm=none
hi StatusLine      ctermfg=255 ctermbg=16
hi StatusLineNC    ctermfg=233 ctermbg=240
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Tag             ctermfg=198
hi Title           ctermfg=166
hi Todo            ctermfg=231 ctermbg=232   cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81                cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
hi VisualNOS                   ctermbg=235
hi Visual                      ctermbg=19
hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
hi WildMenu        ctermfg=81  ctermbg=16

hi Comment         ctermfg=22
hi CursorColumn                ctermbg=236
hi LineNr          ctermfg=250 ctermbg=232
hi NonText         ctermfg=238 ctermbg=232
