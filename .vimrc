" 日本語ヘルプ
set helplang=ja

" カラースキーム
set t_Co=256
colorscheme cohama

" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" Python による IBus の制御
let IM_CtrlIBusPython = 1

" Vim options
set autoindent
set backspace=indent,eol,start
set clipboard=autoselect,unnamed
set cmdheight=3
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nrformats-=octal
set number
set scrolloff=5
set shiftwidth=2
set showcmd
set smartcase
set smartindent
set smarttab
set softtabstop=2
set statusline=%<%f\ (%n)%m%r%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=Line:\ %l,\ Col:\ %c%V%8P
set tabstop=2
set whichwrap+=h,l
set wildmenu
set wildmode=full

" ステータスラインの色をモードで切り替え
autocmd InsertLeave * highlight StatusLine ctermfg=232 ctermbg=255
autocmd InsertEnter * highlight StatusLine ctermfg=255 ctermbg=232

" ハイライトを消す
nnoremap <silent> <C-n> :noh<CR>
autocmd InsertEnter * let @/=""

" Vundle の設定
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
" Vundle で管理するプラグイン
Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache'
Bundle 'Smooth-Scroll'
Bundle 'rails.vim'
filetype plugin indent on
