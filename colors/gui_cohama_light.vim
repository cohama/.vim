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
hi Function        guifg=#006303
hi Statement       guifg=#0000FF               gui=none
hi Conditional     guifg=#0000FF
hi Repeat          guifg=#0000FF
hi Label           guifg=#0000FF
hi Operator        guifg=#0000FF
hi Keyword         guifg=#0000FF
hi Exception       guifg=#0000FF

" programming pre-processes
hi PreProc         guifg=#990099

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
hi CursorLineNr    guifg=#000000 guibg=#FFFF88
hi FoldColumn      guifg=#737373 guibg=#a0a0a0
hi SignColumn                    guibg=#c2c2c2
hi Search          guifg=NONE                  gui=reverse,underline
hi Visual                        guibg=#FFDDDD


" vim: set colorcolumn=20,34,48 iskeyword-=# :