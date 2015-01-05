:%s/<PLUGIN>/\=expand('%:t:r')/ge
if exists('g:loaded_<PLUGIN>')
  finish
endif
let g:loaded_<PLUGIN> = 1

let s:save_cpo = &cpo
set cpo&vim

<CURSOR>

let &cpo = s:save_cpo
