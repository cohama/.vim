" Vim color file
" Maintainer:	cohama <hirotaka.hamada.1024@gmail.com>

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="cohama"

" color terminal definitions
hi Boolean         ctermfg=135
hi Character       ctermfg=144
hi Number          ctermfg=207
hi String          ctermfg=15
hi Conditional     ctermfg=161               cterm=bold
hi Constant        ctermfg=135               cterm=bold
hi Cursor          ctermfg=16  ctermbg=253
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=81

hi DiffAdd                     ctermbg=24
hi DiffChange      ctermfg=181 ctermbg=239
hi DiffDelete      ctermfg=162 ctermbg=53
hi DiffText                    ctermbg=102 cterm=bold

hi Directory       ctermfg=118               cterm=bold
hi Error           ctermfg=219 ctermbg=89
hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
hi Exception       ctermfg=118               cterm=bold
hi Float           ctermfg=135
hi FoldColumn      ctermfg=67  ctermbg=16
hi Folded          ctermfg=183  ctermbg=16
hi Function        ctermfg=218
hi Identifier      ctermfg=208
hi Ignore          ctermfg=244 ctermbg=232
hi IncSearch       ctermfg=193 ctermbg=16

hi Keyword         ctermfg=196               cterm=bold
hi Label           ctermfg=229               cterm=none
hi Macro           ctermfg=193
hi SpecialKey      ctermfg=81

hi MatchParen      ctermfg=255  ctermbg=17 cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Operator        ctermfg=161

" complete menu
hi Pmenu           ctermfg=232  ctermbg=255
hi PmenuSel        ctermfg=255 ctermbg=21
hi PmenuSbar                   ctermbg=32
hi PmenuThumb      ctermfg=81

hi PreCondit       ctermfg=197               cterm=bold
hi PreProc         ctermfg=197
hi Question        ctermfg=81
hi Repeat          ctermfg=161               cterm=bold
hi Search          ctermfg=253 ctermbg=66

" marks column
hi SignColumn      ctermfg=118 ctermbg=235
hi SpecialChar     ctermfg=81               cterm=bold
hi SpecialComment  ctermfg=81               cterm=bold
hi Special         ctermfg=81

hi Statement       ctermfg=226
hi StatusLine      ctermfg=232 ctermbg=255
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Tag             ctermfg=161
hi Title           ctermfg=166
hi Todo            ctermfg=231 ctermbg=232   cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81                cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=235
hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
hi WildMenu        ctermfg=81

hi Normal          ctermfg=254
hi Comment         ctermfg=82
hi LineNr          ctermfg=250 
hi NonText         ctermfg=250

" ruby terms
hi rubyStringEscape ctermfg=175
hi rubyStringDelimiter ctermfg=15
hi rubyDefine ctermfg=226
