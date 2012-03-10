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
set cursorline
set cmdheight=3
set expandtab
set nohidden
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
let hi_insert = 'highlight StatusLine ctermbg=196 ctermfg=255 cterm=bold'

" ハイライトを消す
nnoremap <silent> <C-n> :noh<CR>
autocmd InsertEnter * let @/=""

" タブページの設定
nnoremap <silent> <C-T><C-L> :tabn<CR>
nnoremap <silent> <C-T>l :tabn<CR>
nnoremap <silent> <C-L> :tabn<CR>
nnoremap <silent> <C-T><C-H> :tabp<CR>
nnoremap <silent> <C-T>h :tabp<CR>
nnoremap <silent> <C-H> :tabp<CR>
nnoremap <silent> <C-T><C-W> :tabclose<CR>
nnoremap <silent> <C-T>w :tabclose<CR>
nnoremap <silent> <C-T><C-O> :tabonly<CR>
nnoremap <silent> <C-T>o :tabonly<CR>
nnoremap <silent> <C-T><C-N> :tabnew<CR>
nnoremap <silent> <C-T>n :tabnew<CR>
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

" カーソル位置の単語をヘルプで検索
nnoremap <silent> gh yiw:help <C-r>0<CR>

" 戦闘力を測定
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? '/home/cohama/.vim/.vimrc' : expand(<q-args>), <bang>0)

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
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'motemen/git-vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
filetype plugin indent on

" neocomplcache の設定
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" neocomplcache-snippets-complete の設定
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
imap <C-k> <Plug>(neocomplcache_snippets_jump)
smap <C-k> <Plug>(neocomplcache_snippets_jump)

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

" git-vim の設定
nnoremap <silent> <Leader>gc :GitCommit -v<CR>:set filetype=gitcommit<CR><C-w>H

" vimshell の設定
nnoremap <silent> <Leader>vimsh :VimShell<CR>
nnoremap <silent> <Leader>bash :VimShellInteractive bash<CR>
nnoremap <silent> <Leader>zsh :VimShellInteractive zsh<CR>
nnoremap <silent> <Leader>irb :VimShellInteractive irb<CR>

