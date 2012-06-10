" 日本語ヘルプ
set helplang=ja

" カラースキーム
set t_Co=256
syntax on
colorscheme cohama

" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" Python による IBus の制御
let IM_CtrlIBusPython = 1

" Vim options
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
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
set list
set listchars=tab:>-
set scrolloff=5
set shiftwidth=2
set showcmd
set smartcase
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set whichwrap+=h,l
set wildmenu
set wildmode=full

" 自分用 augroup
augroup CohamaAutoCmd
  autocmd!
augroup END

" ハイライトを消す
nnoremap <silent> <C-n> :noh<CR>
autocmd CohamaAutoCmd InsertEnter * let @/=""

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
nnoremap <silent> ciy ciw<C-R>0<Esc>:let@/=@1<CR>:noh<CR>

" カーソル位置の単語を置換
nnoremap g/ yiw:%s/\<<C-R>0\>//g<Left><Left>

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

" .vimrc .gvimrc に関する設定
nnoremap <silent> <Leader>so :source ~/.vimrc<CR>
nnoremap <silent> <Leader>vimrc :tabe ~/.vim/.vimrc<CR>
nnoremap <silent> <Leader>gvimrc :tabe ~/.vim/.gvimrc<CR>

" magic comment
function! MagicComment()
  let magic_comment = "# encoding: utf-8\n"
  let pos = getpos(".")
  call cursor(1, 0)
  execute ":normal O" . magic_comment
  call setpos(".", pos)
endfunction

nnoremap <silent> <F12> :call MagicComment()<CR>

" 行末の空白をハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd CohamaAutoCmd WinEnter * match WhitespaceEOL /\s\+$/

" ruby コードを実行するコマンド
function! ExecuteRuby(file)
  execute "!ruby ".a:file
endfunction
command! -nargs=? -complete=file RubyExec call ExecuteRuby(empty(<q-args>) ? expand('%') : expand(<q-args>))
autocmd CohamaAutoCmd FileType * nnoremap <F6> <Nop>
autocmd CohamaAutoCmd FileType ruby nnoremap <buffer> <F6> :<C-u>RubyExec<CR>

" console.log をハイライト
highlight JSConsoleLog ctermbg=red guibg=red
autocmd CohamaAutoCmd WinEnter *.js match JSConsoleLog /console.log/

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
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/unite.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tomtom/tcomment_vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'gregsexton/gitv'
Bundle 'derekwyatt/vim-scala'
Bundle 'groenewege/vim-less'
Bundle 'sudo.vim'
Bundle 'IndentAnything'
Bundle 'serverhorror/javascript.vim'
Bundle 'Javascript-Indentation'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'camelcasemotion'
Bundle 'EasyMotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'manalang/jshint.vim'
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
" inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
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
map <silent> <Leader><C-p> :NERDTreeFind<CR>
let NERDTreeIgnore = ['\~$', '\.swp']
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 36
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 1
map <silent> <C-@> :NERDTreeFind<CR>
map <silent> <Leader><C-p> :NERDTreeFind<CR>

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

" vimshell の設定
nnoremap <silent> <Leader>sh :tabnew<CR>:VimShell<CR>
autocmd CohamaAutoCmd FileType vimshell call s:vimshell_my_settings()
function! s:vimshell_my_settings()
  nmap <buffer> q <Plug>(vimshell_exit):q<CR>:tabp<CR>
  imap <buffer> <C-q> <Esc>q
  call vimshell#altercmd#define('l', 'ls -F')
  call vimshell#altercmd#define('la', 'ls -FA')
  call vimshell#altercmd#define('ll', 'ls -alF')
  call vimshell#altercmd#define('jhw', 'bundle exec jasmine-headless-webkit')
endfunction
nnoremap <silent> <Leader>irb :VimShellInteractive irb<CR>
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'

" fugitive の設定
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gc :Gcommit -v<CR><C-w>H
nnoremap <Leader>gps :Git push<CR>
nnoremap <Leader>gpl :Git pull<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Space> :Git 

" unite の設定
nnoremap <silent> <Leader>b :Unite buffer<CR>
nnoremap <silent> <Leader>ug :Unite grep -no-quit<CR>
nnoremap <silent> <Leader>f :Unite file_rec<CR>
let g:unite_update_time = 100
let g:unite_enable_start_insert = 1
autocmd CohamaAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <silent><buffer> <C-q> <Plug>(unite_exit)
  noremap <silent><buffer><expr> t unite#smart_map("t", unite#do_action('tabopen'))
  noremap <silent><buffer><expr> o unite#smart_map("o", unite#do_action('open'))
  noremap <silent><buffer><expr> s unite#smart_map("s", unite#do_action('vsplit'))
  noremap <silent><buffer><expr> S unite#smart_map("S", unite#do_action('split'))
  noremap <silent><buffer><expr> n unite#smart_map("n", unite#do_action('insert'))
endfunction

" gitv の設定
autocmd CohamaAutoCmd FileType git :setlocal foldlevel=99
nnoremap <Leader>gk :Gitv --all<CR>
let g:Gitv_DoNotMapCtrlKey = 1

"indent-guides の設定
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=235
hi IndentGuidesEven ctermbg=233
let g:indent_guides_color_change_percent = 30

" powerline
let g:Powerline_symbols='fancy'
