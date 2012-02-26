" 日本語ヘルプ
set helplang=ja

" カラースキーム
set t_Co=256
colorscheme cohama

" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" Python による IBus の制御
let IM_CtrlIBusPython = 1

