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
set statusline=%<%f\ (%n)%m%r%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=Line:\ %l,\ Col:\ %c%V%8P
set tabstop=2
set whichwrap+=h,l
set wildmenu
set wildmode=full

" ステータスラインの色をモードで切り替え
let hi_insert = 'highlight StatusLine ctermbg=DarkBlue ctermfg=White cterm=none'

" ハイライトを消す
nnoremap <silent> <C-n> :noh<CR>
autocmd InsertEnter * let @/=""

" タブページの設定
nmap <silent> <C-T><C-L> :tabn<CR>
nmap <silent> <C-T>l :tabn<CR>
nmap <silent> <C-L> :tabn<CR>
nmap <silent> <C-T><C-H> :tabp<CR>
nmap <silent> <C-T>h :tabp<CR>
nmap <silent> <C-H> :tabp<CR>
nmap <silent> <C-T><C-W> :tabclose<CR>
nmap <silent> <C-T>w :tabclose<CR>
nmap <silent> <C-T><C-O> :tabonly<CR>
nmap <silent> <C-T>o :tabonly<CR>
nmap <silent> <C-T><C-N> :tabnew<CR>
nmap <silent> <C-T>n :tabnew<CR>
set showtabline=2

" ヤンクした文字列でカーソル位置の単語置き換え
nnoremap <silent> cy ce<C-R>0<Esc>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy ce<C-R>0<Esc>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-R>0<Esc>:let@/=@1<CR>:noh<CR>

" カーソル位置の単語を置換
nnoremap g/ yiw:s/<C-R>0//g<Left><Left>

" カーソル位置の単語をハイライト
function! HilightWordAtCursor()
  let cursor_pos = getpos(".")
  normal yiw
  let @/ = @0
  call setpos(".", cursor_pos)
endfunction
nnoremap <silent> gn :call HilightWordAtCursor()<CR>:set hlsearch<CR>

" % コマンドの拡張
runtime macros/matchit.vim

" ビジュアルモードでのインデントを連続でできるようにする
vnoremap < <gv
vnoremap > >gv

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
Bundle 'vim-scripts/Align'
Bundle 'tpope/vim-surround'
Bundle 'mattn/zencoding-vim'
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

" NERDTree の設定
map <silent> <C-p> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '\.swp']
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 36
let NERDTreeMinimalUI = 1

" surrond.vim の設定
let g:surround_36 = "$(\r)"
let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"
let g:surround_104 = "<%=h \r %>"

" zencoding の設定
let g:use_zen_complete_tag = 1
let g:user_zen_leader_key = '<C-C>'
let g:user_zen_settings = {
\  'lang' : 'ja',
\  'html' : {
\    'filters' : 'html',
\    'indentation' : '  '
\  },
\  'css' : {
\    'filters' : 'fc',
\  },
\  'javascript' : {
\    'snippets' : {
\      'jq' : "$(function() {\n\t${cursor}${child}\n});",
\      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
\      'fn' : "(function() {\n\t${cursor}\n})();",
\      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
\    },
\  },
\ }
