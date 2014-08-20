set iminsert=0 imsearch=0
let g:font_name = get(g:, 'font_name', 'Migu 2M')
let g:font_size = get(g:, 'font_size', 10)
if has('win32') || has('win64')
  let &guifont =  substitute(g:font_name, ' ', '_', 'g') . ':h' . g:font_size . ':cSHIFTJIS'
else
  let &guifont = g:font_name . ' ' . g:font_size
endif
set guioptions&
set guioptions-=e
set guioptions-=T
set guioptions-=m
set guioptions-=a

if g:is_windows
  autocmd myautocmd GUIEnter * simalt ~x
endif
