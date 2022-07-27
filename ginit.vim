if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Monospace 12')
  " tabnew
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  nunmap <C-o>
  " tabnew
  nunmap <C-o><Tab>
  nunmap <C-o><C-p>
elseif exists(':GuiFont')
  " on nvim-qt
  GuiFont! Monospace:h12
  GuiPopupmenu 0
  GuiTabline 0
elseif exists('g:nvui')
  NvuiScrollAnimationDuration 0.1
  let g:font_name = get(g:, 'font_name', 'Monospace')
  let g:font_size = get(g:, 'font_size', 12)
  nunmap <C-d>
  nunmap <C-u>
  nunmap <C-f>
  nunmap <C-b>
  set wrapscan
  let &guifont = g:font_name .. ':h' .. g:font_size .. ",NasuM:h" .. g:font_size
else
  let g:font_name = get(g:, 'font_name', 'Monospace')
  let g:font_size = get(g:, 'font_size', 12)
  let &guifont = g:font_name . ':h' . g:font_size
endif
