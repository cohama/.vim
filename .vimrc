" Initialization {{{
" My autocmd group
augroup myautocmd
  autocmd!
augroup END

" condition variables
let s:is_windows = has('win32') || has('win64')
let s:is_unix = has('unix')
let s:is_gui = has('gui_running')
let s:is_terminal = !s:is_gui

" must be set with multibyte strings
scriptencoding utf-8
" }}}

" Vim options {{{
" ### Indent ### {{{
" 新しい行のインデントを現在行と同じにする
set autoindent

" 高度なインデント
set smartindent

" タブが対応する空白の数
set tabstop=2

" インデントでずれる幅
set shiftwidth=2

" タブキーでカーソルが動く幅
set softtabstop=2

" タブの代わりに空白を挿入
set expandtab

" 空白文字をいいかんじで挿入する
set smarttab
" }}}

" ### Folding ### {{{
" 折りたたみを示す列を表示
set foldcolumn=1

" 最初に折りたたみをなるべく開く
set foldlevel=99

" デフォルトの折りたたみ方法
set foldmethod=marker

" 折りたたまれたテキストの表示方法
set foldtext=MyFoldText()
" }}}

" ### Search ### {{{
" ハイライトで検索
set hlsearch

" 大文字小文字を無視
set ignorecase

" インクリメンタル検索
set incsearch

" 大文字が入力されたら大文字小文字を区別する
set smartcase
" }}}

" ### Buffer ### {{{
" 外部でファイルが変更されたら自動で読みなおす
set autoread

" 隠れ状態にしない
set nohidden
" }}}

" ### View ### {{{
" 色数
set t_Co=256

" コマンドラインの行数
set cmdheight=3

" 現在行の色を変える
set cursorline

" ステータス行を常に表示
set laststatus=2

" 再描画しない (gitv.vim で推奨されている)
set lazyredraw

" 不可侵文字を可視化
set list
set listchars=tab:>\ "

" 行番号を表示 (相対)
set relativenumber

" 最低でも上下に表示する行数
set scrolloff=5

" 入力したコマンドを画面下に表示
set showcmd

" 自動折り返ししない
set textwidth=0

" タブページのラベルを常に表示
set showtabline=2

" 長い行を @ にさせない
set display=lastline

" 記号とかを2倍の幅で表示
set ambiwidth=double

" 埋める文字 (Unite neobundle/install のあとおかしくなる対策)
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:\ ,diff:-

" vim の継続行(\)のインデント量を 0 にする
let g:vim_indent_cont = 0
" }}}

" ### Input ### {{{
" バックスペースで削除できる文字
set backspace=indent,eol,start

" ヤンクなどで * レジスタにも書き込む
set clipboard=unnamed

" ヤンクなどで + レジスタにも書き込む
if has('unnamedplus')
  set clipboard+=unnamedplus
endif

" マッピングの受付時間 (<Leader> とか)
set timeout
set timeoutlen=1000

" キーコードの受付時間 (<Esc> とか)
set ttimeoutlen=100

" 矩形選択を可能にする
set virtualedit& virtualedit+=block

" 行連結で変なことをさせない
set nojoinspaces

" 折り返した行の表示
set showbreak=>\ "
" }}}

" ### Miscellaneous ### {{{
" <C-a> や <C-x> で数値を増減させるときに8進数を無効にする
set nrformats-=octal

" 行をまたいでカーソル移動
set whichwrap&
set whichwrap+=h,l

" コマンドライン補完
set wildmenu

" コマンドライン補完の方法
set wildmode=longest:full,full

" 日本語ヘルプ
set helplang=ja

" K でヘルプを引く
set keywordprg=:help
" }}}
" }}}

" Plugin Bundles {{{
" NeoBundle の設定
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" ### fundamental ### {{{
" プラグイン管理
NeoBundle 'Shougo/neobundle.vim'

" アレをアレする
NeoBundle 'Shougo/unite.vim'

" 非同期実行
if s:is_unix
  NeoBundle 'Shougo/vimproc', {
        \     'build': {
        \        'unix': 'make -f make_unix.mak'
        \     }
        \   }
endif
" }}}

" ### 入力系 ### {{{
" 入力補完
NeoBundle 'Shougo/neocomplcache'

" スニペット補完
NeoBundle 'Shougo/neosnippet'

" Zen-Coding
NeoBundle 'mattn/zencoding-vim'

" endfunction とかを自動入力
NeoBundle 'tpope/vim-endwise'

" 対応する括弧の自動入力
NeoBundle 'kana/vim-smartinput'
" }}}

" ### 編集を便利にする ### {{{
" 整形
NeoBundle 'h1mesuke/vim-alignta'

" テキストオブジェクトのまわりに文字を挿入
NeoBundle 'tpope/vim-surround'

" コメント化
NeoBundle 'tomtom/tcomment_vim'

" インデントが同じ物をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-indent', {'depends': 'kana/vim-textobj-user'}

" 全体をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-entire', {'depends': 'kana/vim-textobj-user'}
" }}}

" ### ファイル操作など ### {{{
" ディレクトリ、ファイルをツリー表示
NeoBundle 'scrooloose/nerdtree'

" sudo で保存
NeoBundle 'sudo.vim'

" ファイラ
NeoBundle 'Shougo/vimfiler'
" }}}

" ### 移動 ### {{{
" CamelCase や snake_case での単語移動
NeoBundle 'bkad/CamelCaseMotion'

" カーソルを任意の位置にジャンプさせる
NeoBundle 'EasyMotion'

" 記号とかに邪魔されずに w, b, e できる
NeoBundle 'kana/vim-smartword'

" f のあと ; のかわりに f 連打で移動できる
NeoBundle 'rhysd/clever-f.vim'
" }}}

" ### 見た目、カラースキーム ### {{{
" かっこいいステータスライン
NeoBundle 'Lokaltog/vim-powerline'

" インデントの量を可視化
NeoBundle 'nathanaelkane/vim-indent-guides'

" GUI 用カラースキームを変換できる
NeoBundleLazy 'godlygeek/csapprox', {'autoload' : {
      \   'commands': 'CSApproxSnapshot',
      \ }}

" color schemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'

" エラー箇所をハイライトする
NeoBundle 'jceb/vim-hier'

" エラーの原因をコマンドウィンドウに出力
NeoBundle 'dannyob/quickfixstatus'
" }}}

" ### Git ### {{{
" 直接 Git コマンド実行など
NeoBundle 'tpope/vim-fugitive'

" gitk っぽいものを Vim で
NeoBundle 'gregsexton/gitv'
" }}}

" ### Language ### {{{
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'groenewege/vim-less'
NeoBundle 'cohama/vim-javascript'
NeoBundle 'leafgarland/typescript-vim'

" Ruby オムニ補完
NeoBundle 'cohama/rsense', {
      \     'build': {
      \        'unix': '/bin/sh install.sh'
      \      }
      \    }

" JavaScript シンタックスチェック
NeoBundleLazy 'cohama/jshint.vim'
" }}}

" ### 何かを実行 ### {{{
" Vim で動く shell
NeoBundle 'Shougo/vimshell'

" その場で実行
NeoBundle 'thinca/vim-quickrun'

" 独自のモードを設定
NeoBundle 'thinca/vim-submode'

" Vim から URL を開く
NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload': {
      \   'mappings': [
      \                 ['n', '<Plug>(openbrowser-smart-search)'],
      \                 ['v', '<Plug>(openbrowser-smart-search)']]
      \ }}

" vim-quickrun hooks 集
NeoBundle "osyo-manga/shabadou.vim", {
      \ 'depends': ['thinca/vim-quickrun', 'Shougo/vimproc', 'Shougo/unite.vim', 'osyo-manga/unite-quickfix']}

" 非同期でシンタックスチェック
NeoBundle 'osyo-manga/vim-watchdogs', {
      \ 'depends': ['thinca/vim-quickrun', 'Shougo/vimproc', 'osyo-manga/shabadou.vim']}
" }}}

" ### Unite Souceses ### {{{
NeoBundle "osyo-manga/unite-quickfix"

NeoBundle 'tsukkee/unite-help'
" }}}

" ### Miscellaneous ### {{{
NeoBundleLazy 'motemen/hatena-vim'

" コードを Gist に送るためのプラグイン
NeoBundle 'mattn/gist-vim', {
      \     'depends': 'mattn/webapi-vim'
      \    }

" Scouter
NeoBundleLazy 'thinca/vim-scouter', {
      \ 'autoload': {'commands': 'Scouter'}
      \ }

" }}}
" }}}

" Plugin Settings {{{
" NeoBundle の設定 {{{
filetype plugin indent on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
nnoremap <Leader>une :Unite neobundle/
nmap <Leader>uni <Leader>so:Unite neobundle/install<CR>
nmap <Leader>unI <Leader>so:Unite neobundle/install:!<CR>
" }}}

" neocomplcache の設定 {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_max_list = 200
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
autocmd myautocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd myautocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd myautocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd myautocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.javascript = ''
let g:neocomplcache_omni_patterns.ruby = '[^. \t]\.\%(\h\w*\)\?\|\h\w*::'
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.ruby = 'RSenseCompleteFunction'
" autocmd myautocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'javascript': expand('~/.vim/dict/javascript.dict')}

" 補完メニューの設定
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" }}}

" neosnippet の設定 {{{
let g:neosnippet#snippets_directory = expand('~/.vim/snippets')
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}

" vim-ruby の設定 {{{
let g:rubycomplete_buffer_loadding = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
" }}}

" NERDTree の設定 {{{
map <silent> <C-p> :NERDTreeToggle<CR>
map <silent> <Leader><C-p> :NERDTreeFind<CR>
let NERDTreeIgnore = ['\~$', '\.swp']
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 36
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 1
map <silent> <C-@> :NERDTreeFind<CR>
map <silent> <Leader><C-p> :NERDTreeFind<CR>
" }}}

" Align の設定 {{{
map <Leader><Leader>rwp <Plug>RestoreWinPosn
map <Leader><Leader>swp <Plug>SaveWinPosn
" }}}

" surrond.vim の設定 {{{
let g:surround_36 = "$(\r)"
let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"
let g:surround_104 = "<%=h \r %>"
" }}}

" zencoding の設定 {{{
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
" }}}

" vimshell の設定 {{{
nnoremap <silent> <Leader>sh :tabnew<CR>:VimShell<CR>
autocmd myautocmd FileType vimshell call s:vimshell_my_settings()
function! s:vimshell_my_settings()
  nmap <buffer> q <Plug>(vimshell_exit):q<CR>
  imap <buffer> <C-q> <Esc>q
  call vimshell#altercmd#define('l', 'ls -F')
  call vimshell#altercmd#define('la', 'ls -FA')
  call vimshell#altercmd#define('ll', 'ls -alF')
  call vimshell#altercmd#define('jhw', 'bundle exec jasmine-headless-webkit')
  nnoremap <buffer> <silent> <C-l> :tabn<CR>
  inoremap <buffer> <silent> <C-l> <Esc>:tabn<CR>
  inoremap <buffer> <silent> <C-h> <Esc>:tabp<CR>
  inoremap <buffer> <expr><silent> <C-p> unite#sources#vimshell_history#start_complete(!0)
endfunction
nnoremap <Leader>si :VimShellInteractive<Space>
nnoremap <silent> <Leader>irb :VimShellInteractive irb<CR>
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" }}}

" fugitive の設定 {{{
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gc :Gcommit -v<CR><C-w>H
nnoremap <Leader>gps :Git push<CR>
nnoremap <Leader>gpl :Git pull<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Space><Space> :Git<Space>
nnoremap <Space>s :<C-u>Gstatus<CR>
nnoremap <Space>d :<C-u>Gdiff<CR>
nnoremap <Space>a :<C-u>Gwrite<CR>
nnoremap <Space>A :<C-u>Git add -A<CR>
nnoremap <Space>c :<C-u>Gcommit -v<CR><C-w>H
nnoremap <Space>C :<C-u>Gcommit -av<CR><C-w>H
nnoremap <Space>p :<C-u>Git push<CR>
nnoremap <Space>f :<C-u>Git fetch<CR>
nnoremap <Space>b :<C-u>Gblame<CR>
" }}}

" unite の設定 {{{
nnoremap U :<C-u>Unite<Space>
nnoremap <Leader>u <Nop>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>ug :<C-u>Unite grep -no-quit<CR>
nnoremap <silent> <Leader>f :<C-u>Unite file_rec<CR>
nnoremap <silent> <Leader>ur :<C-u>UniteResume<CR>
nnoremap <silent> <Leader>uf :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark -default-action=vimfiler -no-start-insert<CR>
nnoremap <silent> <Leader>uB :<C-u>UniteBookmarkAdd<CR>
let g:unite_update_time = 100
let g:unite_enable_start_insert = 1
autocmd myautocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <silent><buffer> <C-q> <Plug>(unite_exit)
  map <silent><buffer> <Esc> <Plug>(unite_exit)
  noremap <silent><buffer><expr> t unite#smart_map("t", unite#do_action('tabopen'))
  noremap <silent><buffer><expr> o unite#smart_map("o", unite#do_action('open'))
  noremap <silent><buffer><expr> s unite#smart_map("s", unite#do_action('vsplit'))
  noremap <silent><buffer><expr> S unite#smart_map("S", unite#do_action('split'))
  noremap <silent><buffer><expr> n unite#smart_map("n", unite#do_action('insert'))
  noremap <silent><buffer><expr> f unite#smart_map("f", unite#do_action('vimfiler'))
  noremap <silent><buffer><expr> F unite#smart_map("f", unite#do_action('tabvimfiler'))
endfunction
" }}}

" endwise {{{
let g:endwise_no_mappings = 1
autocmd myautocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
" }}}

" gitv の設定 {{{
autocmd myautocmd FileType git setlocal foldlevel=99
nnoremap <Leader>gk :Gitv --all<CR>
nnoremap <Space>k :Gitv --all<CR>
let g:Gitv_DoNotMapCtrlKey = 1
let g:Gitv_TruncateCommitSubjects = 1
" }}}

"indent-guides の設定 {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let s:indent_guides_odd_guibg = "#0D0D24"
let s:indent_guides_even_guibg = "#151538"
autocmd myautocmd ColorScheme * exec "hi IndentGuidesOdd ctermbg=233 guibg=" . s:indent_guides_odd_guibg
autocmd myautocmd ColorScheme * exec "hi IndentGuidesEven ctermbg=235 guibg=" . s:indent_guides_even_guibg
let g:indent_guides_color_change_percent = 30
" }}}

" powerline {{{
if s:is_windows
  let g:Powerline_symbols='compatible'
else
  let g:Powerline_symbols='fancy'
endif
" }}}

" coffeescript {{{
let coffee_make_options = '--bare'
let coffee_compiler = 'coffee'
let coffee_linter = 'coffeelint'
nnoremap <Leader>cc :CoffeeCompile<CR>
nnoremap <Leader>cm :CoffeeMake<CR>
nnoremap <Leader>cl :CoffeeLint<CR>
" }}}

" vimfiler {{{
nnoremap <Leader>F :VimFiler<CR>
let g:vimfiler_safe_mode_by_default = 0
" }}}

" smartword{{{
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['_'] = {
      \ 'hook/close_unite_quickfix/enable_hook_loaded': 1,
      \ 'hook/close_buffer/enable_empty_data'         : 1,
      \ 'hook/close_quickfix/enable_exit'             : 1,
      \ 'outputter'                                   : 'multi:buffer:quickfix',
      \ 'outputter/buffer/split'                      : 'botright 8',
      \ 'runner'                                      : 'vimproc',
      \ 'runner/vimproc/updatetime'                   : 40}
let g:quickrun_config['watchdogs_checker/_'] = {
      \ 'hook/close_unite_quickfix/enable_exit': 1,
      \ 'hook/close_quickfix/enable_exit': 1}
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'bundle',
      \ 'exec': '%c exec rspec -f d %s'}
autocmd myautocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
" }}}

" submode.vim {{{
let g:submode_leave_with_key = 1
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
" }}}

" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" watchdogs {{{
call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_CursorHold_enable = 1
" }}}

" smartinput {{{
call smartinput#map_to_trigger('i', '<', '<', '<')
call smartinput#define_rule({'at': '\$("\%#")', 'char': '<', 'input': '</><Left><Left>', 'filetype': ['javascript']})
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#define_rule({'at': '<\%#', 'char': '%', 'input': '%<Space>%><Left><Left><Left>'})
smap <CR> <BS>i
" }}}

" Rsense {{{
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = expand('$HOME/.vim/bundle/rsense')
function! SetUpRubySetting()
  " setlocal completefunc=RSenseCompleteFunction
  nmap <buffer>Kd :RSenseJumpToDefinition<CR>
  nmap <buffer>Kw :RSenseWhereIs<CR>
  nmap <buffer>Kt :RSenseTypeHelp<CR>
endfunction
autocmd myautocmd FileType ruby,eruby,ruby.rspec call SetUpRubySetting()
" }}}

" hatena-vim {{{
let g:hatena_user='cohama'
" }}}
" }}}

" Settings and keymaps {{{
" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>

" Python による IBus の制御
let IM_CtrlIBusPython = 1

" ハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>noh<CR>
autocmd myautocmd InsertEnter * let @/=""

" terminal でも Meta キーを使いたい
if s:is_unix && s:is_terminal
  " Use meta keys in console.
  function! s:use_meta_keys()  " {{{
    for i in map(
    \   range(char2nr('a'), char2nr('z'))
    \ + range(char2nr('A'), char2nr('Z'))
    \ + range(char2nr('0'), char2nr('9'))
    \ , 'nr2char(v:val)')
      " <ESC>O do not map because used by arrow keys.
      if i != 'O'
        execute 'nmap <ESC>' . i '<M-' . i . '>'
      endif
    endfor
  endfunction  " }}}

  call s:use_meta_keys()
  map <NUL> <C-Space>
  map! <NUL> <C-Space>
endif

" タブページの設定
nnoremap <silent> <C-T><C-L> :tabn<CR>
nnoremap <silent> <C-T>l :tabn<CR>
nnoremap <silent> <C-L> :tabn<CR>
nnoremap <silent> <C-T><C-H> :tabp<CR>
nnoremap <silent> <C-T>h :tabp<CR>
nnoremap <silent> <C-H> :tabp<CR>
nnoremap <silent> <C-T><C-W> :tabclose<CR>
nnoremap <silent> <C-T>w :tabclose<CR>
nnoremap <silent> <C-T>W :tabclose!<CR>
nnoremap <silent> <C-T><C-O> :tabonly<CR>
nnoremap <silent> <C-T>o :tabonly<CR>
nnoremap <silent> <C-T><C-N> :tabnew<CR>
nnoremap <silent> <C-T>n :tabnew<CR>
nnoremap <C-T><C-e> :tabedit<Space>
nnoremap <C-T>e :tabedit<Space>

nnoremap <silent> <M-l> :tabnext<CR>
nnoremap <silent> <M-h> :tabprevious<CR>
nnoremap <silent> <M-n> :tabnew<CR>
nnoremap <silent> <M-w> :tabclose<CR>
nnoremap <silent> <M-W> :tabonly<CR>
nnoremap <M-e> :tabedit<Space>
inoremap <silent> <M-l> <Esc>:tabnext<CR>
inoremap <silent> <M-h> <Esc>:tabprevious<CR>

" ヤンクした文字列でカーソル位置の単語置き換え
nmap <silent> cy ce<C-R>0<Esc>:let@/=@1<CR>:noh<CR>
nmap <silent> ciy ciw<C-R>0<Esc>:let@/=@1<CR>:noh<CR>

" カーソル位置の単語を置換
nnoremap g/ :<C-u>%s/\<<C-R><C-w>\>//g<Left><Left>
nnoremap g? :<C-u>%s/\<<C-R><C-w>\>//gc<Left><Left><Left>

" カーソル位置の単語をハイライト
function! HilightWordAtCursor()
  let cursor_pos = getpos(".")
  normal! yiw
  let @/ = "\\<" . @0 . "\\>"
  call setpos(".", cursor_pos)
endfunction
nnoremap <silent> gn :<C-u>call HilightWordAtCursor()<CR>:set hlsearch<CR>

" % コマンドの拡張
runtime macros/matchit.vim

" ビジュアルモードでのインデントを連続でできるようにする
xmap < <gv
xmap > >gv

function! MyScouter()
  Scouter ~/.vim/.vimrc ~/.vim/.gvimrc
endfunction
command! MyScouter call MyScouter()

" .vimrc .gvimrc に関する設定
if s:is_gui
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>:source $MYGVIMRC<CR>
else
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>
endif
nnoremap <silent> <Leader>v :tabe ~/.vim/.vimrc<CR>
nnoremap <silent> <Leader>gv :tabe ~/.vim/.gvimrc<CR>

" magic comment
function! MagicComment()
  let magic_comment = "# encoding: utf-8\n"
  let pos = getpos(".")
  call cursor(1, 0)
  0put =magic_comment
  call setpos(".", pos)
endfunction

nnoremap <silent> <F12> :call MagicComment()<CR>

" JavaScript を開いたとき
function! WhenJavaScriptOpened()
  setlocal foldmethod=syntax
endfunction
autocmd myautocmd FileType javascript call WhenJavaScriptOpened()

" 見た目通りに上下移動
" thanks to tyru
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" カーソルの桁座標が動かない gj, gk
nmap gj lhj
nmap gk lhk

" 検索結果で画面を真ん中に
nnoremap n nzzzv
nnoremap N Nzzzv

" インサートモードから出るときにカーソルを後退させない
function! FixedInsertLeave()
  " 行末だった場合は通常と同じく後退させる
  let cursorPos = col(".")
  let maxColumn = col("$")
  if cursorPos < maxColumn && cursorPos != 1
    return "\<Esc>l"
  else
    return "\<Esc>"
  endif
endfunction
imap <silent><expr> <Esc> FixedInsertLeave()

" 指定したタブをすべて閉じる
function! CloseTabsByNrList(closing_tabnr_list)
  let offset = 0
  for i in a:closing_tabnr_list
    exec 'tabclose ' . (str2nr(i) - offset)
    let offset = offset + 1
  endfor
endfunction

" 自分と vimshell, git, gitv 以外のウィンドウを全て閉じる
function! ExtendedOnly()
  let tabcount = tabpagenr('$')
  let current_tabnr = tabpagenr()
  let deleting_tabs = []
  for t in range(1, tabcount)
    let wincount = tabpagewinnr(t, '$')
    for w in range(1, wincount)
      let filetype = gettabwinvar(t, w, '&filetype')
      if filetype !=? 'vimshell' && filetype !=? 'git' && filetype !=? 'gitv'
        if current_tabnr !=# t
          call add(deleting_tabs, t)
          break
        endif
      endif
    endfor
  endfor
  call CloseTabsByNrList(deleting_tabs)
  only
endfunction
command! Only call ExtendedOnly()

" help を開いたとき
function! WhenHelpOpened()
  " 左のウィンドウで開く
  exec "normal " .  "\<C-w>H\<C-w>82|"
  " q だけで閉じれるようにする
  nnoremap <buffer> q ZZ
endfunction
autocmd myautocmd FileType help call WhenHelpOpened()

" my smooth scroll
let s:scroll_time_ms = 100
let s:scroll_precision = 8
function! CohamaSmoothScroll(dir, windiv, factor)
  let cl = &cursorline
  set nocursorline
  let height = winheight(0) / a:windiv
  let n = height / s:scroll_precision
  if n <= 0
    let n = 1
  endif
  let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
  let i = 0
  let scroll_command = a:dir == "down" ?
        \ "normal " . n . "\<C-E>" . n ."j" :
        \ "normal " . n . "\<C-Y>" . n ."k"
  while i < s:scroll_precision
    let i = i + 1
    execute scroll_command
    execute "sleep " . wait_per_one_move_ms . "m"
    redraw
  endwhile
  let &cursorline = cl
  echo "My Smooth Scroll"
endfunction
nnoremap <silent> <C-d> :call CohamaSmoothScroll("down", 2, 1)<CR>
nnoremap <silent> <C-u> :call CohamaSmoothScroll("up", 2, 1)<CR>
nnoremap <silent> <C-f> :call CohamaSmoothScroll("down", 1, 2)<CR>
nnoremap <silent> <C-b> :call CohamaSmoothScroll("up", 1, 2)<CR>

" ビジュアルモードで選択した部分を置換
xmap / y:%s/<C-r>"//g<Left><Left>
xmap ? y:%s/<C-r>"//gc<Left><Left><Left>

" 行末までをヤンク
nmap Y y$

" コマンドモードのマッピング
cmap <C-a> <Home>
cmap <C-b> <Left>
cmap <C-f> <Right>

" タブページの移動
function! MoveTabPage(dir)
  if a:dir == "right"
    let n = tabpagenr()
  elseif a:dir == "left"
    let n = tabpagenr() - 2
  endif
  if n >= 0
    execute "tabm " . n
  endif
endfunction
nnoremap <silent> <C-t>L :call MoveTabPage("right")<CR>
nnoremap <silent> <C-t>H :call MoveTabPage("left")<CR>

" 右側のタブをすべて閉じる
function! CloseAllRightTabs()
  let current_tabnr = tabpagenr()
  let last_tabnr = tabpagenr("$")
  let num_close = last_tabnr - current_tabnr
  let i = 0
  while i < num_close
    execute "tabclose " . (current_tabnr + 1)
    let i = i + 1
  endwhile
endfunction
nnoremap <silent> <C-t>dl :<C-u>call CloseAllRightTabs()<CR>

" 左側のタブをすべて閉じる
function! CloseAllLeftTabs()
  let current_tabnr = tabpagenr()
  let num_close = current_tabnr - 1
  let i = 0
  while i < num_close
    execute "tabclose 1"
    let i = i + 1
  endwhile
endfunction
nnoremap <silent> <C-t>dh :<C-u>call CloseAllLeftTabs()<CR>

" オリジナル foldtext
function! MyFoldText()
  let line = getline(v:foldstart)
  let marker_removed = substitute(line, '{{{', '', 'g') " }}}
  let line_count = v:foldend - v:foldstart
  let lines = line_count > 1 ? ' lines' : ' line'
  let count_in_brace = substitute(marker_removed, '{\s*$', '{ ('.line_count.lines.') }', '')
  return count_in_brace
endfunction

" gitcommit, gitrebase を開いた時
function! WhenGitCommitOpened()
  " q で保存して終了
  nnoremap <buffer> q ZZ
  " commit cancel
  nnoremap <buffer> Q ggdGZZ
endfunction
autocmd myautocmd FileType gitcommit,gitrebase call WhenGitCommitOpened()

" 改行だけを入力する
nmap go o<Esc>
nmap gO O<Esc>

" Insert モードの時に行番号の色を反転
" 参考 plugin/insert-statusline.vim
let s:highlight_args = ["ctermfg", "ctermbg", "guifg", "guibg"]
function! GetHighlight(highlight_group)
  redir => hl
  silent execute 'highlight ' . a:highlight_group
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hi_dict = {}
  for hi_arg in s:highlight_args
    let args_list = matchlist(hl, hi_arg . '=\(\S\+\)')
    if len(args_list) > 1
      let hi_dict[hi_arg] = args_list[1]
    endif
  endfor
  return hi_dict
endfunction
function! InvertFgBg(hi_dict)
  let inverted = {}
  if has_key(a:hi_dict, "ctermfg") && has_key(a:hi_dict, "ctermbg")
    let inverted.ctermfg = a:hi_dict.ctermbg
    let inverted.ctermbg = a:hi_dict.ctermfg
  endif
  if has_key(a:hi_dict, "guifg") && has_key(a:hi_dict, "guibg")
    let inverted.guifg = a:hi_dict.guibg
    let inverted.guibg = a:hi_dict.guifg
  endif
  return inverted
endfunction
function! HighlightDictToString(highlight_dict)
  let str = ""
  for hi_arg in s:highlight_args
    if has_key(a:highlight_dict, hi_arg) && a:highlight_dict[hi_arg] != ""
      let str .= hi_arg . "=" . a:highlight_dict[hi_arg] . " "
    endif
  endfor
  return str
endfunction
function! InitializeDefaultLineNr()
  silent! let s:normal_normal = GetHighlight('Normal')
  silent! let s:normal_linenr = extend(copy(s:normal_normal), GetHighlight('LineNr'))
  silent! let s:normal_cursorlinenr = extend(copy(s:normal_normal), GetHighlight('CursorLineNr'))
  let s:insert_linenr = InvertFgBg(s:normal_linenr)
  let s:insert_cursorlinenr = InvertFgBg(s:normal_cursorlinenr)
endfunction
function! ToInsertLineNr()
  if exists("s:insert_linenr") && exists("s:insert_cursorlinenr")
    silent exec 'highlight LineNr ' . HighlightDictToString(s:insert_linenr)
    silent exec 'highlight CursorLineNr ' . HighlightDictToString(s:insert_cursorlinenr)
  endif
endfunction
function! ToNormalLineNr()
  if exists("s:normal_linenr") && exists("s:normal_cursorlinenr")
    silent exec 'highlight LineNr ' . HighlightDictToString(s:normal_linenr)
    silent exec 'highlight CursorLineNr ' . HighlightDictToString(s:normal_cursorlinenr)
  endif
endfunction
autocmd myautocmd ColorScheme * call InitializeDefaultLineNr()
autocmd myautocmd InsertEnter * call ToInsertLineNr()
autocmd myautocmd InsertLeave * call ToNormalLineNr()

" インサートモードのマッピング
inoremap <C-e> <End>
inoremap <C-a> <C-o>^
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" カーソル行を空行化
nmap cc 0D

" タブ幅4のもの
autocmd myautocmd FileType typescript,java setl shiftwidth=4 tabstop=4

" 今開いているタブページを次のタブページに統合する
" Window が複数あるときは何もしない
function! JointNextTabpage()
  let wincount = winnr('$')
  if wincount != 1
    return
  endif
  let filename = expand('%')
  quit
  execute 'vsplit '.filename
endfunction
command! TabJoin call JointNextTabpage()
nnoremap <silent> <C-t>J :<C-u>TabJoin<CR>

" dk と dj を対称にする
nnoremap dk dkk

" 再描画したい
nnoremap <Leader><C-l> :<C-u>redraw!<CR>

" ビジュアルモードで選択したところ以外を削除
xnoremap D x0"_Dp==

" カレントウィンドウだけ行のハイライトをする
autocmd myautocmd WinEnter * setlocal cursorline
autocmd myautocmd WinLeave * setlocal nocursorline

" xml の folding
let g:xml_syntax_folding = 1
autocmd myautocmd FileType xml setl foldmethod=syntax

" シンタックス情報の取得
function! GetSyntaxID(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! GetSyntaxAttr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! GetSyntaxInfo()
  let baseSyn = GetSyntaxAttr(GetSyntaxID(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = GetSyntaxAttr(GetSyntaxID(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call GetSyntaxInfo()

" Window の移動
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W
nnoremap <Leader><Tab> <C-W>W

" Jump
nmap <C-O> <Nop>
nnoremap <C-O><C-I> <C-O>
nnoremap <C-O><C-P> <C-I>

function! ColorSchemeSettings()
  syntax on
  if g:colors_name == "solarized"
    hi Error guibg=#000000
  endif
  " 行末の空白と全角スペースをハイライト
  function! MatchIllegalSpaces()
    if !exists("w:tailing_space")
      let w:tailing_space = matchadd("Error", '\s\+$', 11) 
      let w:zenkaku_space = matchadd("Error", '　', 11)
    endif
  endfunction
  autocmd myautocmd WinEnter,BufEnter * call MatchIllegalSpaces()
  autocmd myautocmd FileType help,vimshell,unite call clearmatches()

  " JavaScript の console.log をハイライト
  function! MatchConsoleLog()
    if !exists("w:console_log")
      let w:console_log = matchadd("Error", 'console\.log')
    endif
  endfunction
  autocmd myautocmd WinEnter,BufEnter *.js call MatchConsoleLog()
  autocmd myautocmd FileType javascript call MatchConsoleLog()
endfunction
autocmd myautocmd ColorScheme * call ColorSchemeSettings()

" かしこい Home
" thanks to Shougo
function! SmartHome()
  let str_before_cursor = strpart(getline('.'), 0, col('.') - 1)
  let wrap_prefix = &wrap ? 'g' : ''
  if str_before_cursor !~ '^\s*$'
    return wrap_prefix . '^'
  else
    return wrap_prefix . '0'
  endif
endfunction
noremap <expr> ^ SmartHome()
sunmap ^
noremap <expr> H SmartHome()
sunmap H

" かしこい End
nnoremap <expr> L &wrap ? 'g$' : '$'
onoremap <expr> L &wrap ? 'g$' : '$'
xnoremap <expr> L &wrap ? 'g$h' : '$h'

" number, relativenumber の切り替え
function! TogglelRelativeNumber()
  if &relativenumber
    set norelativenumber number
  elseif &number
    set nonumber
  else
    set relativenumber
  endif
endfunction
nnoremap [Toggle] <Nop>
nmap M [Toggle]
nnoremap [Toggle]n :<C-u>call TogglelRelativeNumber()<CR>

" さっき編集した範囲を選択
nnoremap gV `[v`]

" set paste 状態でクリップボードから貼り付け
command! -nargs=0 Paste call CohamaPaste()
function! CohamaPaste()
  set paste
  normal! "+p
  set nopaste
endfunction
inoremap <C-R>+ <C-o>:Paste<CR>

" 括弧を扱う textobj を簡単に入力できるようにする
" thanks to Shougo
" <angle>
onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>

" [rectangle]
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]

" 'quote'
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'

" "double quote"
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"

" visual mode でレジスタを汚さず削除
xnoremap x "_x

" o, O でコメントを継続しない
autocmd myautocmd FileType * setlocal formatoptions-=o

" トグルコマンド
function! Toggle(option, ...)
  let local_flag = (a:0 > 1) ? a:1 : ""
  let set_command = (local_flag ==? "local") ? "setlocal " : "set "
  execute set_command . a:option . "!"
  execute set_command . a:option . "?"
endfunction
nnoremap <expr> [Toggle]w Toggle("wrap", "local")
nnoremap <expr> [Toggle]l Toggle("list", "local")
nnoremap <expr> [Toggle]p Toggle("paste", "local")
nnoremap <expr> [Toggle]t Toggle("expandtab", "local")
nnoremap [Toggle]N :<C-u>NeoComplCacheToggle<CR>
nnoremap [Toggle]I :<C-u>IndentGuidesToggle<CR>

" 全自動保存モード
function! FullAutoWriteToggle()
  if exists('s:full_auto_write') && s:full_auto_write == 1
    let s:full_auto_write = 0
    set noautowriteall
    augroup FullAutoWriteToggle
      autocmd!
    augroup END
    echo 'FullAutoWrite Disabled.'
  else
    let s:full_auto_write = 1
    set autowriteall
    augroup FullAutoWriteToggle
      autocmd InsertLeave,CursorHold * update
    augroup END
    echo 'FullAutoWrite Enabled.'
  endif
endfunction
nnoremap <expr> [Toggle]W FullAutoWriteToggle()

" <C-G> で fileformat fileencoding filetype とかもだす
function! SuperRuler()
  redir => ruler_out
    silent file
  redir END
  " なぜか改行が入るので
  let ruler_out = strpart(ruler_out, 1)

  let super_ruler = ruler_out . "    | " . &fileformat . " | " . &fileencoding . " | " . &filetype . " |"
  echo super_ruler
endfunction
nnoremap <C-G> :<C-u>call SuperRuler()<CR>

" フォーマット変えて開き直す系
command! Utf8 edit ++enc=utf-8 %
command! Cp932 edit ++enc=cp932 %
command! Unix edit ++ff=unix %
command! Dos edit ++ff=dos %

" インデントを簡単に設定
" ISetting t4 => tab で幅4
" ISetting s2 => space で幅2
function! ISetting(setting)
  if strlen(a:setting) == 2
    let expandtab = a:setting[0]
    let shiftwidth = a:setting[1]
  else
    echo "Arg Error"
    return
  endif
  if expandtab ==? "t"
    set noexpandtab
  elseif expandtab ==? "s"
    set expandtab
  endif

  let &shiftwidth = shiftwidth
  let &softtabstop = shiftwidth
  let &tabstop = shiftwidth

  " IndentGuides を再描画させるため
  doautocmd WinEnter

  let current_indent_setting = "indent: " . ((&expandtab) ? "space" : "tab") . " " . &shiftwidth
  echo current_indent_setting
endfunction
command! -nargs=1 ISetting call ISetting(<f-args>)
"}}}

" ColorScheme {{{
if s:is_windows
  let s:indent_guides_odd_guibg = "#FFFAEB"
  let s:indent_guides_even_guibg = "#EEE8D5"
  set background=light
  colorscheme solarized
elseif s:is_gui
  colorscheme cohama
else
  colorscheme cui_cohama
endif
" }}}
