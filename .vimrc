" 日本語ヘルプ
set helplang=ja

" カラースキーム
set t_Co=256
colorscheme molokai

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
let hi_insert = 'highlight StatusLine ctermbg=DarkBlue ctermfg=White cterm=none'

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
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
filetype plugin indent on

" neocomplcache の設定
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_camel_case_completion = 1

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" 補完メニューの設定
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" vim-ruby の設定
let g:rubycomplete_buffer_loadding = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

