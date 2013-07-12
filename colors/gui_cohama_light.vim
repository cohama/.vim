" My Color Theme

set background=light
highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'gui_cohama_light'

" base
hi Normal          guifg=#404040 guibg=#F4F4F4 gui=none

" programming literals
hi Comment         guifg=#52A36B
hi Constant        guifg=#0A5DD1               gui=bold
hi String          guifg=#BD2B00
hi Character       guifg=#BD6100
hi Number          guifg=#FF00B3
hi Boolean         guifg=#FF00B3
hi Float           guifg=#FF00B3

" programming statements
hi Identifier      guifg=#7A0000               gui=none
hi Function        guifg=#00A303
hi Statement       guifg=#0000FF               gui=none
hi Conditional     guifg=#0000FF
hi Repeat          guifg=#0000FF
hi Label           guifg=#0000FF
hi Operator        guifg=#0000FF
hi Keyword         guifg=#0000FF
hi Exception       guifg=#0000FF

" programming pre-processes
hi PreProc         guifg=#990099
hi Define          guifg=#990099

" programming types
hi Type            guifg=#DB0000               gui=none

" specials
hi Special         guifg=#00616E

" vim views
hi Cursor                        guibg=#000000
hi CursorIM                      guibg=#880000
hi CursorLine                    guibg=#DDDDFF gui=none
hi CursorColumn                  guibg=#DDDDFF gui=none
hi ColorColumn                   guibg=#FFADAD
hi LineNr          guifg=#606060 guibg=#E4E4E4
hi CursorLineNr    guifg=#000000 guibg=#C0C0FF
hi FoldColumn      guifg=#373737 guibg=#a0a0a0
hi SignColumn                    guibg=#c2c2c2
hi Search          guifg=NONE                  gui=reverse,underline
hi Visual                        guibg=#88DDFF
hi Error           guifg=#CC0000 guibg=#880000
hi VertSplit       guifg=#232323 guibg=#232323
hi Pmenu           guifg=#404040 guibg=#DDDDDD
hi PmenuSel                      guibg=#BBBBBB
hi PmenuSbar                     guibg=#888888
hi PmenuThumb                    guibg=#555555

" vim: set colorcolumn=20,34,48 iskeyword-=# :
