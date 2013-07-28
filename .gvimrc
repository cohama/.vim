if has('win32') || has('win64')
  set guifont=Migu_2M:h10:cSHIFTJIS
else
  set guifont=Migu\ 2M\ 10
endif
set guioptions&
set guioptions-=T
set guioptions-=m
set guioptions-=a


" zencoding の設定
execute 'map <C-CR> ' . g:user_zen_leader_key . ','
execute 'imap <C-CR> ' . g:user_zen_leader_key . ','

" 補完候補を逆にたどる
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" surround.vim のキーバインド
nmap <M-s> ysiw

if g:is_windows
  autocmd myautocmd GUIEnter * simalt ~x
endif
