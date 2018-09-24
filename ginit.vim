if exists('g:GtkGuiLoaded')
  " some code here
  call rpcnotify(1, 'Gui', 'Font', 'Monospace 12')
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
