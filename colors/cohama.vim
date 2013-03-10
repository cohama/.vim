" My Color Theme
"   based on molokai

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="cohama"

hi Normal gui=none guifg=#AAAAAA guibg=#121230
hi CursorLine                    guibg=#1D1D4D
hi CursorColumn                  guibg=#1D1D4D
hi Comment         guifg=#505050
hi LineNr          guifg=#8080FF guibg=#0C0C21
hi CursorLineNr gui=bold guifg=#FFFFFF guibg=#1D1D4D
hi NonText gui=none guifg=#303050 guibg=#0C0C21

hi Constant        guifg=#AE81FF               gui=bold
hi String          guifg=#DC6F10
hi Character       guifg=#DC9010
hi Number          guifg=#FF8AF5
hi default link Float Number
hi default link Boolean Number

hi Identifier      guifg=#F2D38A
hi Function        guifg=#90DB65

hi Statement       gui=none guifg=#E04F83
hi Conditional     guifg=#F92672
hi Repeat          guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Operator        guifg=#F92672
hi Keyword gui=none guifg=#E6E695
hi Exception       guifg=#A6E22E               gui=bold

hi Type gui=none guifg=#66D9EF
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#5B88F0               gui=bold
hi Delimiter       guifg=#8F8F8F
hi diffAdded       guifg=#E69487
hi diffRemoved     guifg=#597A7A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#7684a7 guibg=#000000
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen                    guibg=#28009E gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74

" complete menu
hi Pmenu           guifg=#002D80 guibg=#C7DBFF
hi PmenuSel        guifg=#FFFFFF guibg=#004DC0
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Search          guifg=#FFFFFF guibg=#455354
" marks column
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
hi SpecialKey      guifg=#888A85               gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi StatusLine      guifg=#FFFFFF guibg=#000000
hi StatusLineNC    guifg=#404040 guibg=#000000
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual          guifg=#FFFFFF guibg=#669CFF
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000


