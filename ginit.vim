if exists('g:GtkGuiLoaded')
  " some code here
  call rpcnotify(1, 'Gui', 'Font', 'Monospace 12')
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
elseif exists(':GuiFont')
  " on nvim-qt
  GuiFont! Monospace:h10
  GuiPopupmenu 0
  GuiTabline 0
else
  let g:font_name = get(g:, 'font_name', 'Monospace')
  let g:font_size = get(g:, 'font_size', 12)
  let &guifont = g:font_name . ':h' . g:font_size
endif
