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
let s:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8') && !(exists('g:discard_unicode') && g:discard_unicode != 0)

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
nohlsearch

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
let g:cursorline_flg = 1 " cursorline はウィンドウローカルなのでグローバルなフラグを用意しておく

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

" 埋める文字
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

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
if s:is_unicode
  let &showbreak = "\u21b3 "
else
  let &showbreak = "`-"
endif
" }}}

" ### Command ### {{{
" コマンドライン補完
set wildmenu

" コマンドライン補完の方法
set wildmode=longest:full,full

" コマンドの履歴の保存数
set history=500
" }}}

" ### Miscellaneous ### {{{
" <C-a> や <C-x> で数値を増減させるときに8進数を無効にする
set nrformats-=octal

" 行をまたいでカーソル移動
set whichwrap&
set whichwrap+=h,l

" 日本語ヘルプ
set helplang=ja

" K でヘルプを引く
set keywordprg=:help

" swap への書き込みや CursorHold 発生の間隔
set updatetime=1000

" いろんなコマンドの後にカーソルを戦闘に移動させない
set nostartofline
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
NeoBundleFetch 'Shougo/neobundle.vim'

" アレをアレする
NeoBundleLazy 'Shougo/unite.vim', {
\ 'autoload' : {
\   'commands' : [{ 'name' : 'Unite',
\                   'complete' : 'customlist,unite#complete_source'},
\                 'UniteWithCursorWord', 'UniteWithInput']
\ }}
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
NeoBundleLazy 'Shougo/neocomplcache', {
\ 'autoload' : {
\   'insert' : 1
\ }}

" スニペット補完
NeoBundleLazy 'Shougo/neosnippet', {
\ 'autoload' : {
\   'insert' : 1,
\   'filetypes' : 'snippet',
\ }}

" Zen-Coding
NeoBundleLazy 'mattn/zencoding-vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'eruby', 'jsp', 'xml'],
\   'commands' : ['<Plug>ZenCodingExpandNormal']
\ }}

" endfunction とかを自動入力
NeoBundleLazy 'tpope/vim-endwise', {
\ 'autoload' : {
\   'filetypes' : ['lua', 'ruby', 'sh', 'zsh', 'vb', 'vbnet', 'aspvbs', 'vim']
\ }}

" 対応する括弧の自動入力
NeoBundleLazy 'kana/vim-smartinput', {
\ 'autoload' : {
\   'insert' : 1
\ }}

" echo area に情報を表示
NeoBundleLazy 'Shougo/echodoc', {
\ 'autoload' : {
\   'insert' : 1
\ }}

" }}}

" ### 編集を便利にする ### {{{
" 整形
NeoBundleLazy 'h1mesuke/vim-alignta', {
\ 'autoload' : {
\   'commands' : ['Alignta', 'Align']
\ }}

" テキストオブジェクトのまわりに文字を挿入
NeoBundleLazy 'tpope/vim-surround', {
\ 'autoload' : {
\   'mappings' : [['n', 'ys'], ['n', 'ds'], ['n', 'cs'], ['x', 'S']]
\ }}

" コメント化
NeoBundleLazy 'tomtom/tcomment_vim', {
\ 'autoload' : {
\   'mappings' : [['nx', 'gc'], ['nx', 'gC']]
\ }}

" インデントが同じ物をテキストオブジェクト化
NeoBundleLazy 'kana/vim-textobj-indent', {
\ 'depends' : 'kana/vim-textobj-user',
\ 'autoload' : {
\   'mappings' : [['ox', 'ii'], ['ox', 'ai'], ['ox', 'iI'], ['ox', 'aI']]
\ }}

" 全体をテキストオブジェクト化
NeoBundleLazy 'kana/vim-textobj-entire', {
\ 'depends' : 'kana/vim-textobj-user',
\ 'autoload' : {
\   'mappings' : [['ox', 'ie'], ['ox', 'ae']]
\ }}

" 関数をテキストオブジェクト化
NeoBundleLazy 'kana/vim-textobj-function', {
\ 'depends' : 'kana/vim-textobj-user',
\ 'autoload': {
\   'mappings': [['ox', 'if'], ['ox', 'af']],
\   'filetypes': ['vim', 'c']
\ }}

" JavaScript の関数をテキストオブジェクト化を追加
NeoBundleLazy 'thinca/vim-textobj-function-javascript', {
\ 'autoload' : {
\   'filetypes' : 'javascript'
\ }}

" 任意の文字に囲まれた部分をテキストオブジェクト化
NeoBundleLazy 'thinca/vim-textobj-between', {
\ 'depends' : 'kana/vim-textobj-user',
\ 'autoload' : {
\   'mappings': ['<Plug>(textobj-between-i)', '<Plug>(textobj-between-a)']
\ }}

" Ruby のメソッドをテキストオブジェクト化
NeoBundleLazy 't9md/vim-textobj-function-ruby', {
\ 'depends' : 'vim-ruby',
\ 'autoload' : {
\   'filetypes' : 'ruby'
\ }}

" ヤンクしたものと対称の文字列を置き換える
NeoBundleLazy 'kana/vim-operator-replace', {
\ 'depends' : 'kana/vim-operator-user',
\ 'autoload' : {
\   'mappings' : ['<Plug>(operator-replace)']
\ }}

" snake_case -> CamelCase にするオペレータ
NeoBundleLazy 'tyru/operator-camelize.vim', {
\ 'depends' : 'kana/vim-operator-user',
\ 'autoload' : {
\   'mappings' : ['<Plug>(operator-camelize-toggle)']
\ }}
" }}}

" ### ファイル操作など ### {{{
" ディレクトリ、ファイルをツリー表示
NeoBundle 'scrooloose/nerdtree', {
\ 'augroup' : 'NERDTreeHijackNetrw',
\ 'autoload' : {
\   'commands' : ['NERDTreeToggle', 'NERDTreeFind']
\ }}

" sudo で保存
NeoBundleLazy 'sudo.vim', {
\ 'autoload' : {
\   'commands' : ['SudoWrite', 'SudoRead']
\ }}

" ファイラ
NeoBundleLazy 'Shougo/vimfiler', {
\ 'autoload' : {
\   'commands' : [{'name' : 'VimFiler',
\                  'complete' : 'customlist,vimfiler#complete' },
\                 'VimFilerBufferDir', 'VimFilerCurrentDir', 'VimFilerSplit', 'VimFilerExplorer', 'VimFilerTab']
\ }}

" 一時ファイル的な
NeoBundleLazy 'Shougo/junkfile.vim', {
\ 'autoload' : {
\   'commands' : ["JunkfileOpen"],
\   'unite_sources' : ["junkfile", "junkfile/new"]
\ }}
" }}}

" ### 移動 ### {{{
" CamelCase や snake_case での単語移動
NeoBundleLazy 'bkad/CamelCaseMotion', {
\ 'autoload' : {
\   'mappings' : [',w', ',e', ',b', ',ge']}}

" カーソルを任意の位置にジャンプさせる
NeoBundleLazy 'EasyMotion', {'autoload' : {
\ 'mappings' : ['\\w', '\\b', '\\e', '\\ge', '\\W', '\\B', '\\E', '\\gE', '\\f', '\\F', '\\t', '\\T']
\ }}

" 記号とかに邪魔されずに w, b, e できる
NeoBundleLazy 'kana/vim-smartword', {
\ 'autoload' : {
\   'mappings' : ["<Plug>(smartword-w)", "<Plug>(smartword-b)", "<Plug>(smartword-e)", "<Plug>(smartword-ge)"]
\ }}

" 選択したところを検索
NeoBundleLazy 'thinca/vim-visualstar', { 'autoload' : {
\ 'mappings' : ['<Plug>(visualstar-*)', '<Plug>(visualstar-#)', '<Plug>(visualstar-g*)', '<Plug>(visualstar-g#)']
\ }}
" }}}

" ### 見た目、カラースキーム ### {{{
" かっこいいステータスライン
NeoBundle 'Lokaltog/vim-powerline'

" インデントの量を可視化
NeoBundle 'nathanaelkane/vim-indent-guides'

" GUI 用カラースキームを変換できる
NeoBundleLazy 'godlygeek/csapprox', {
\ 'autoload' : {
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

" 複数箇所をハイライト
NeoBundleLazy 't9md/vim-quickhl', {
\ 'autoload' : {
\   'mappings' : ["<Plug>(quickhl-toggle)", "<Plug>(quickhl-match)"]
\ }}

" 桁をハイライト
NeoBundleLazy 'cohama/easy-colorcolumn', {
\ 'autoload' : {
\   'mappings' : ["<Plug>(easy-colorcolumn-add)", "<Plug>(easy-colorcolumn-toggle)"]
\ }}
" }}}

" ### Git ### {{{
" 直接 Git コマンド実行など
NeoBundle 'tpope/vim-fugitive', {
\ 'augroup': 'fugitive',
\ }

" gitk っぽいものを Vim で
NeoBundle 'gregsexton/gitv', {
\ 'depends' : 'vim-fugitive',
\ 'autoload' : {
\   'commands' : ['Gitv']
\ }}

" git のステータスを行の横に表示
NeoBundle 'airblade/vim-gitgutter'

" git のコミットメッセージをバルーンで表示
NeoBundleLazy 'rhysd/git-messenger.vim', {
\ 'autoload' : {
\   'mappings' : ['<Plug>(git-messenger-commit-summary)', '<Plug>(git-messenger-commit-message)']
\ }}
" }}}

" ### Language ### {{{
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'vim-ruby/vim-ruby', {
\ 'autoload': {
\   'filetypes' : ['ruby', 'eruby']
\ }}
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'groenewege/vim-less'
NeoBundleLazy 'pangloss/vim-javascript', {
\ 'autoload': {
\   'filetypes' : 'javascript'
\ }}
NeoBundle 'leafgarland/typescript-vim'
" }}}

" ### 何かを実行 ### {{{
" Vim で動く shell
NeoBundle 'Shougo/vimshell', {
\ 'autoload' : {
\   'commands' : [{ 'name' : 'VimShell',
\                   'complete' : 'customlist,vimshell#complete'},
\                 'VimShellExecute', 'VimShellInteractive',
\                 'VimShellTerminal', 'VimShellPop'],
\   'mappings' : ['<Plug>(vimshell_switch)']
\ }}

" その場で実行
NeoBundle 'thinca/vim-quickrun', {
\ 'autoload' : {
\   'mappings' : [['n', '\r']],
\   'commands' : ['QuickRun']
\ }}

" 独自のモードを設定
NeoBundleLazy 'thinca/vim-submode', {
\ 'autoload' : {
\   'mappings' : [['n', "\<C-W>+"], ['n', "\<C-W>-"], ['n', "\<C-W>>"], ['n', "\<C-W><"]]
\ }}

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
NeoBundleLazy "osyo-manga/unite-quickfix", {
\ 'autoload' : {
\   'unite_sources': ['quickfix']
\ }}

NeoBundle 'tsukkee/unite-help', {
\ 'autoload' : {
\   'unite_sources': ['help']
\ }}

NeoBundleLazy 'ujihisa/unite-rake', {
\ 'autoload' : {
\   'unite_sources': ['rake']
\ }}

NeoBundleLazy 'basyura/unite-rails'

NeoBundleLazy 'Shougo/unite-outline', {
\ 'autoload' : {
\   'unite_sources' : ['outline']
\ }}

NeoBundleLazy 'thinca/vim-unite-history', {
\ 'autoload' : {
\   'unite_sources' : ['history/command', 'history/search']
\ }}
" }}}

" ### Miscellaneous ### {{{
NeoBundleLazy 'motemen/hatena-vim'

" コードを Gist に送るためのプラグイン
NeoBundle 'mattn/gist-vim', {
\ 'depends': 'mattn/webapi-vim',
\ 'autoload' : {
\   'commands' : 'Gist'
\ }}

" Scouter
NeoBundleLazy 'thinca/vim-scouter', {
\ 'autoload': {
\   'commands': 'Scouter'
\ }}

" }}}
" }}}

" Plugin Settings {{{
" NeoBundle の設定 {{{
filetype plugin indent on
" Installation check.
NeoBundleCheck
if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif
nnoremap <Leader>une :Unite neobundle/
nnoremap <Leader>uni :Unite neobundle/install<CR>
nnoremap <Leader>unI :Unite neobundle/install:!<CR>
nnoremap <Leader>unu :Unite neobundle/update:all<CR>
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
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup()
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
\ 'javascript': expand('~/.vim/dict/javascript.dict'),
\ 'ocaml' : expand('~/.vim/dict/ocaml.dict')
\ }

" 補完メニューの設定
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" }}}

" neosnippet の設定 {{{
let g:neosnippet#snippets_directory = expand('~/.vim/snippets')
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
snoremap <CR> <BS>i
snoremap <C-l> <Esc>a
" }}}

" vim-ruby の設定 {{{
let g:rubycomplete_buffer_loadding = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
" }}}

" vim-operator-replace の設定 {{{
map _ <Plug>(operator-replace)
sunmap _

" operator-camelize の設定 {{{
map - <Plug>(operator-camelize-toggle)
sunmap -
" }}}
" }}}

" NERDTree の設定 {{{
nnoremap <silent> <C-p> :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <C-@> :<C-u>NERDTreeFind<CR>
nnoremap <silent> <Leader><C-p> :<C-u>NERDTreeFind<CR>
let NERDTreeIgnore = ['\~$', '\.swp', '^\.$', '^\.\.$']
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 36
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 1
if !s:is_unicode
  let NERDTreeDirArrows = 0
endif
" }}}

" surrond.vim の設定 {{{
let g:surround_36 = "$(\r)"
let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"
let g:surround_104 = "<%=h \r %>"
" }}}

" textobj-between の設定
let g:textobj_between_no_default_key_mappings = 1
omap i/ <Plug>(textobj-between-i)
xmap i/ <Plug>(textobj-between-i)
omap a/ <Plug>(textobj-between-a)
xmap a/ <Plug>(textobj-between-a)

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
autocmd myautocmd FileType vimshell call s:vimshell_my_settings()
function! s:vimshell_my_settings()
  call vimshell#altercmd#define('l', 'ls -F')
  call vimshell#altercmd#define('la', 'ls -FA')
  call vimshell#altercmd#define('ll', 'ls -alF')
  call vimshell#altercmd#define('jhw', 'bundle exec jasmine-headless-webkit')
  call vimshell#altercmd#define('be', 'bundle exec')
  nmap <buffer> H <Plug>(vimshell_move_head)
  nmap <buffer> S <Plug>(vimshell_change_line)
endfunction
nnoremap <Leader>s <Nop>
nnoremap <silent> <Leader>s<CR> :<C-u>VimShell<CR>
nnoremap <silent> <Leader>sh :<C-u>tabnew<CR>:VimShell<CR>
nnoremap <silent> <Leader>ss :<C-u>botright vnew<CR>:VimShell<CR>
nnoremap <Leader>si :<C-u>VimShellInteractive<Space>
nnoremap <silent> <Leader>irb :<C-u>botright VimShellInteractive irb<CR>
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" }}}

" quickhl の設定 {{{
nmap gm <Plug>(quickhl-toggle)
xmap gm <Plug>(quickhl-toggle)
nmap gM <Plug>(quickhl-reset)
xmap gM <Plug>(quickhl-reset)
" }}}

" easy-colorcolumn の設定 {{{
nmap gb <Plug>(easy-colorcolumn-toggle)
xmap gb <Plug>(easy-colorcolumn-toggle)
nmap gB <Plug>(easy-colorcolumn-clear)
" }}}

" fugitive の設定 {{{
nnoremap [Git] <Nop>
nmap <Space> [Git]
nnoremap [Git]<Space> :<C-u>Git<Space>
nnoremap [Git]<CR> :<C-u>Git<Space>
nnoremap [Git]s :<C-u>Gstatus<CR>
nnoremap [Git]d :<C-u>Gdiff<CR>
nnoremap [Git]a :<C-u>Gwrite<CR>
nnoremap [Git]A :<C-u>Git add -A<CR>
nnoremap [Git]c :<C-u>Gcommit -v<CR>
nnoremap [Git]C :<C-u>Gcommit --amend<Space>
nnoremap [Git]p :<C-u>Git push<CR>
nnoremap [Git]f :<C-u>Git fetch<CR>
nnoremap [Git]b :<C-u>Gblame<CR>
autocmd myautocmd FileType git call GitSettings()
function! GitSettings()
  setlocal foldtext=fugitive#foldtext()
endfunction
" }}}

" unite の設定 {{{
nnoremap U :<C-u>Unite<Space>
nnoremap <Leader>u <Nop>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>ug :<C-u>Unite grep -no-quit<CR>
nnoremap <silent> <Leader>f :<C-u>Unite file_rec/async<CR>
nnoremap <silent> <Leader>ur :<C-u>UniteResume<CR>
nnoremap <silent> <Leader>uf :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark -default-action=vimfiler -no-start-insert<CR>
nnoremap <silent> <Leader>uB :<C-u>UniteBookmarkAdd<CR>
cnoremap <expr> / (getcmdline() == '' && getcmdtype() == '/') ? "<BS>:Unite line<CR>" : "/"
cnoremap <expr> ? (getcmdline() == '' && getcmdtype() == '?') ? "<BS>:Unite line:backward<CR>" : "?"
nnoremap [I :<C-U>UniteWithCursorWord line:backward<CR>
nnoremap ]I :<C-U>UniteWithCursorWord line:all<CR>
nnoremap <Leader>/ :<C-u>UniteWithInput line<CR><C-r>/<CR>
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
  imap <silent><buffer> <C-N> <Plug>(unite_select_next_line)<Esc>
  nmap <silent><buffer> <C-N> j
endfunction
" }}}

" endwise {{{
let g:endwise_no_mappings = 1
autocmd myautocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
" }}}

" gitv の設定 {{{
autocmd myautocmd FileType git setlocal nofoldenable foldlevel=0
autocmd myautocmd FileType gitv call GitvSettings()
function! GitToggleFolding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction
function! GitvGetCurrentHash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction
function! GitvSettings()
  setlocal iskeyword+=/,-

  nmap <buffer> U ugg<CR>
  cnoremap <expr> <C-r><C-h> GitvGetCurrentHash()
  nnoremap <silent><buffer> J :<C-u>windo call GitToggleFolding()<CR>1<C-w>w
  nnoremap <buffer> . :<C-u> <C-r>=GitvGetCurrentHash()<CR><Home>
  nnoremap <buffer> [Git]r :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]i :<C-u>Git rebase -i <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR>
  nnoremap <buffer> [Git]h :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR>
  nnoremap <buffer> [Git]a :<C-u>Git add -A<CR>
  nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
endfunction
nnoremap [Git]k :<C-u>Gitv --all<CR>
nnoremap [Git]K :<C-u>Gitv!<CR>
let g:Gitv_TruncateCommitSubjects = 1
" }}}

" gitgutter の設定 {{{
let g:gitgutter_eager = 0
nmap <silent> ]h :<C-u>execute v:count1 . "GitGutterNextHunk"<CR>
nmap <silent> [h :<C-u>execute v:count1 . "GitGutterPrevHunk"<CR>
nnoremap [Git]g :<C-u>GitGutter<CR>
nnoremap [Git]G :<C-u>GitGutterAll<CR>
" }}}

" git-messenger {{{
nmap [Git]m <Plug>(git-messenger-commit-summary)
nmap [Git]M <Plug>(git-messenger-commit-message)
" }}}

" tcomment の設定 {{{
let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''
" }}}

"indent-guides の設定 {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let s:indent_guides_odd_guibg = "#0D0D24"
let s:indent_guides_even_guibg = "#151538"
let s:indent_guides_guifg = "#444466"
let s:indent_guides_odd_ctermbg = "235"
let s:indent_guides_even_ctermbg = "233"
let s:indent_guides_ctermfg = "238"
autocmd myautocmd ColorScheme * exec "hi IndentGuidesOdd" .
\ " ctermbg=" . s:indent_guides_odd_ctermbg .
\ " ctermfg=" . s:indent_guides_ctermfg .
\ " guibg=" . s:indent_guides_odd_guibg .
\ " guifg=" . s:indent_guides_guifg
autocmd myautocmd ColorScheme * exec "hi IndentGuideseven" .
\ " ctermbg=" . s:indent_guides_even_ctermbg .
\ " ctermfg=" . s:indent_guides_ctermfg .
\ " guibg=" . s:indent_guides_even_guibg .
\ " guifg=" . s:indent_guides_guifg
" }}}

" powerline {{{
if s:is_unicode
  let g:Powerline_symbols='fancy'
else
  let g:Powerline_symbols='compatible'
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
nnoremap [VimFiler] <Nop>
nmap <Leader>F [VimFiler]
nnoremap [VimFiler]<CR> :<C-u>VimFiler<CR>
nnoremap [VimFiler]s :<C-u>VimFilerSplit<CR>
nnoremap [VimFiler]t :<C-u>VimFilerTab<CR>
nnoremap [VimFiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap [VimFiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap [VimFiler]e :<C-u>VimFilerExplorer<CR>
nnoremap [VimFiler]E :<C-u>VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
let g:vimfiler_safe_mode_by_default = 0
autocmd myautocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
  if s:is_unicode
    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_readonly_file_icon = '✗'
    let g:vimfiler_marked_file_icon = '✓'
  endif
endfunction
" }}}

" JunkFile の設定 {{{
let g:junkfile#edit_command = "tabedit"
" }}}

" EasyMotion {{{
map ;w \\w
map ;b \\b
map ;e \\e
map ;ge \\ge
map ;W \\W
map ;B \\B
map ;E \\E
map ;gE \\gE
map ;f \\f
map ;F \\F
map ;t \\t
map ;T \\T
sunmap ;w
sunmap ;b
sunmap ;e
sunmap ;ge
sunmap ;W
sunmap ;B
sunmap ;E
sunmap ;gE
sunmap ;f
sunmap ;F
sunmap ;t
sunmap ;T
" }}}

" smartword{{{
nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
xmap w <Plug>(smartword-w)
xmap b <Plug>(smartword-b)
xmap e <Plug>(smartword-e)
xmap ge <Plug>(smartword-ge)
" }}}

" visualstar {{{
let g:visualstar_no_default_key_mappings = 1
xmap * <Plug>(visualstar-*)
xmap # <Plug>(visualstar-#)
xmap g* <Plug>(visualstar-g*)
xmap g# <Plug>(visualstar-g#)
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['_'] = {
      \ 'hook/close_buffer/enable_failure'            : 1,
      \ 'hook/close_buffer/enable_empty_data'         : 1,
      \ 'hook/close_quickfix/enable_exit'             : 1,
      \ 'outputter'                                   : 'multi:buffer:quickfix',
      \ 'outputter/buffer/split'                      : 'botright 8',
      \ 'outputter/buffer/name'                       : 'Out',
      \ 'outputter/buffer/close_on_empty'             : 1,
      \ 'runner'                                      : 'vimproc',
      \ 'runner/vimproc/updatetime'                   : 40}
let g:quickrun_config['watchdogs_checker/_'] = {
      \ 'hook/close_unite_quickfix/enable_exit': 1,
      \ 'hook/close_quickfix/enable_exit': 1}
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'bundle',
      \ 'exec': '%c exec rspec -f d %s'}
autocmd myautocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec | setlocal syntax=ruby
autocmd myautocmd BufWinEnter Out setlocal winfixheight
" }}}

" submode.vim {{{
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0
call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')
call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
call submode#map('winsize', 'n', '', '>', '<C-W>>')
call submode#map('winsize', 'n', '', '<', '<C-W><')
call submode#map('winsize', 'n', '', '+', '<C-W>+')
call submode#map('winsize', 'n', '', '-', '<C-W>-')
" }}}

" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
xmap gx <Plug>(openbrowser-smart-search)
" }}}

" watchdogs {{{
call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
\ 'scala' : 0
\ }
if !executable('jshint')
  let g:watchdogs_check_BufWritePost_enables.javascript = 0
endif
" }}}

" smartinput {{{
call smartinput#map_to_trigger('i', '<', '<', '<')
call smartinput#define_rule({'at': '\$("\%#")', 'char': '<', 'input': '</><Left><Left>', 'filetype': ['javascript']})
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#define_rule({'at': '<\%#', 'char': '%', 'input': '%<Space>%><Left><Left><Left>'})
call smartinput#define_rule({'at': '{\%#', 'char': '%', 'input': '%%<Left>'})
call smartinput#define_rule({'at': '{%\%#%}', 'char': '<BS>', 'input': '<BS><Del>'})
call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#define_rule({'at': '(\%#)', 'char': '*', 'input': '**<Left>', 'filetype': ['ocaml']})
call smartinput#define_rule({'at': '(\*\%#\*)', 'char': '<BS>', 'input': '<BS><Del>', 'filetype': ['ocaml']})
call smartinput#define_rule({'at': '\%#', 'char': "'", 'input': "'", 'filetype': ['ocaml', 'scala']})
call smartinput#define_rule({'at': '\[\%#\]', 'char': '<Enter>', 'input': '<Enter><Enter><Up><Esc>"_S', 'filetype': ['javascript']})

call smartinput#map_to_trigger('c', 'C', 'C', 'C')
call smartinput#map_to_trigger('c', 'D', 'D', 'D')
call smartinput#map_to_trigger('c', 'I', 'I', 'I')
call smartinput#define_rule({'at': 'Unite \%#', 'char': 'D', 'input': '<C-u>UniteWithInputDirectory<Space>', 'mode': ':'})
call smartinput#define_rule({'at': 'Unite \%#', 'char': 'I', 'input': '<C-u>UniteWithInput<Space>', 'mode': ':'})
call smartinput#define_rule({'at': 'Unite \%#', 'char': 'C', 'input': '<C-u>UniteWithCursorWord<Space>', 'mode': ':'})

call smartinput#map_to_trigger('c', 'c', 'c', 'c')
call smartinput#map_to_trigger('c', 'm', 'm', 'm')
call smartinput#define_rule({'at': 'Gcommit --amend \%#', 'char': 'c', 'input': '-C HEAD', 'mode': ':'})
call smartinput#define_rule({'at': 'Gcommit --amend \%#', 'char': 'C', 'input': '-C HEAD', 'mode': ':'})
call smartinput#define_rule({'at': 'Git ca\%#', 'char': 'm', 'input': '<C-u>Gcommit --amend ', 'mode': ':'})
" }}}

" echodoc {{{
let g:echodoc_enable_at_startup = 1
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

" terminal でも Meta キーを使いたい
if s:is_unix && s:is_terminal
  " Use meta keys in console.
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

  map <NUL> <C-Space>
  map! <NUL> <C-Space>
endif

" タブページの設定
nnoremap <silent> <M-l> :<C-u>tabnext<CR>
nnoremap <silent> <M-h> :<C-u>tabprevious<CR>
nnoremap <silent> <M-n> :<C-u>tabnew<CR>
nnoremap <silent> <M-w> :<C-u>tabclose<CR>
nnoremap <silent> <M-W> :<C-u>tabonly<CR>
nnoremap <M-e> :<C-u>tabedit<Space>
inoremap <silent> <M-l> <Esc>:tabnext<CR>
inoremap <silent> <M-h> <Esc>:tabprevious<CR>

" カーソル位置の単語を置換
nnoremap g/ :<C-u>%s/\<<C-R><C-w>\>//g<Left><Left>
nnoremap g? :<C-u>%s/\<<C-R><C-w>\>//gc<Left><Left><Left>
xnoremap g/ :s/\<<C-r><C-w>\>//g<Left><Left>
xnoremap g? :s/\<<C-R><C-w>\>//gc<Left><Left><Left>

" カーソル位置の単語をハイライト
" 同じ単語の場合はハイライト削除
function! ToggleHilightWordAtCursor(word)
  let cursor_pos = getpos(".")
  if getreg('/') ==# a:word && (exists('s:hl_word_at_cursor') && s:hl_word_at_cursor)
    let s:hl_word_at_cursor = 0
    return ":\<C-U>nohlsearch\<CR>"
  else
    let s:hl_word_at_cursor = 1
    let @" = a:word
    let @/ = a:word
    return ":\<C-U>set hlsearch\<CR>"
  endif
  call setpos(".", cursor_pos)
endfunction
nnoremap <expr><silent> gn ToggleHilightWordAtCursor(expand("<cword>"))
xnoremap <expr><silent> gn "y:\<C-R>=ToggleHilightWordAtCursor(getreg('0'))\<CR>\<BS>\<CR>"

" % コマンドの拡張
runtime macros/matchit.vim

" ビジュアルモードでのインデントを連続でできるようにする
xnoremap < <gv
xnoremap > >gv

" 戦闘力(俺用)
command! MyScouter Scouter ~/.vim/.vimrc ~/.vim/.gvimrc

" 現在のバッファが空っぽならば :drop それ以外なら :tab drop になるコマンド
function! SmartDrop(tabedit_args)
  if expand('%') == "" && !&modified
    let drop_cmd = "drop "
  else
    let drop_cmd = "tab drop "
  endif
  silent execute drop_cmd . a:tabedit_args
endfunction
command! -nargs=* SmartDrop call SmartDrop(<q-args>)

" .vimrc .gvimrc に関する設定
if s:is_gui
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>:source $MYGVIMRC<CR>
else
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>
endif
nnoremap <silent> <Leader>v :<C-u>SmartDrop ~/.vim/.vimrc<CR>
nnoremap <silent> <Leader>gv :<C-u>SmartDrop ~/.vim/.gvimrc<CR>

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
  wincmd H
  82wincmd |
  nnoremap <buffer> q ZZ
  setlocal winfixwidth
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
xnoremap / y:%s/<C-r>"//g<Left><Left>
xnoremap ? y:%s/<C-r>"//gc<Left><Left><Left>

" 行末までをヤンク
nnoremap Y y$

" コマンドモードのマッピング
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
if !empty(maparg("\<CR>", 'c'))
  cunmap <CR>
endif
if !empty(maparg("\<NL>", 'c'))
  cunmap <NL>
endif

" / で検索するときに単語境界をトグルする
cnoremap <C-\><C-i> <C-\>eToggleWordBounds(getcmdtype(), getcmdline())<CR>
function! ToggleWordBounds(type, line)
  if a:type == '/' || a:type == '?'
    if a:line =~# '^\\<.*\\>$'
      return substitute(a:line, '^\\<\(.*\)\\>$', '\1', '')
    else
      return '\<' . a:line . '\>'
    endif
  else
    return a:line
  endif
endfunction

" / と :s///g をトグルする
cnoremap <expr> <C-\><C-O> ToggleSubstituteSearch(getcmdtype(), getcmdline())
function! ToggleSubstituteSearch(type, line)
  if a:type == '/' || a:type == '?'
    let range = GetOnetime('s:range', '%')
    return "\<End>\<C-U>\<BS>" . substitute(a:line, '^\(.*\)', ':' . range . 's/\1', '')
  elseif a:type == ':'
    let g:line = a:line
    let [s:range, expr] = matchlist(a:line, '^\(.*\)s\%[ubstitute]\/\(.*\)$')[1:2]
    if s:range == "'<,'>"
      call setpos('.', getpos("'<"))
    endif
    return "\<End>\<C-U>\<BS>" . '/' . expr
  endif
endfunction
function! GetOnetime(varname, defaultValue)
  if exists(a:varname)
    let varValue = eval(a:varname)
    execute 'unlet ' . a:varname
    return varValue
  else
    return a:defaultValue
  endif
endfunction

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
  wincmd H
  82wincmd |
  nnoremap <buffer> q ZZ
  nnoremap <buffer> Q ggdGZZ
  setlocal winfixwidth
endfunction
autocmd myautocmd FileType gitcommit,gitrebase call WhenGitCommitOpened()

" 改行だけを入力する
nnoremap go mzo<Esc>`z
nnoremap gO mzO<Esc>`z


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
nnoremap cc 0D

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
autocmd myautocmd WinEnter * if g:cursorline_flg | setlocal cursorline | endif
autocmd myautocmd WinLeave * if g:cursorline_flg | setlocal nocursorline | endif

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
  autocmd myautocmd FileType help,vimshell,unite,vimfiler call clearmatches()
  autocmd myautocmd WinEnter,BufEnter * call s:clear_error_highlight_if()
  function! s:clear_error_highlight_if()
    " 隠れ状態になっているときに match されるのに対処
    if &filetype ==# 'help' || &filetype ==# 'vimshell' ||
    \  &filetype ==# 'unite' || &filetype ==# 'vimfiler'
      call clearmatches()
    endif
  endfunction

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
inoremap <C-R><C-\> <C-o>:set paste<CR>
autocmd myautocmd InsertLeave * set nopaste

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
nnoremap [Toggle] <Nop>
nmap M [Toggle]
nnoremap [Toggle]w :<C-u>call Toggle("wrap", "local")<CR>
nnoremap [Toggle]l :<C-u>call Toggle("list", "local")<CR>
nnoremap [Toggle]p :<C-u>call Toggle("paste", "local")<CR>
nnoremap [Toggle]t :<C-u>call Toggle("expandtab", "local")<CR>
nnoremap [Toggle]c <Nop>
nnoremap [Toggle]cl :<C-u>let g:cursorline_flg = !g:cursorline_flg<CR>:call Toggle("cursorline")<CR>
nnoremap [Toggle]cc :<C-u>call Toggle("cursorcolumn")<CR>
nnoremap [Toggle]s :<C-u>call Toggle("spell", "local")<CR>
nnoremap [Toggle]n :<C-u>call Toggle("number", "local")<CR>
nnoremap [Toggle]r :<C-u>call Toggle("relativenumber", "local")<CR>
nnoremap [Toggle]h :<C-u>call Toggle("hlsearch")<CR>
nnoremap [Toggle]N :<C-u>NeoComplCacheToggle<CR>
nnoremap [Toggle]I :<C-u>IndentGuidesToggle<CR>
nnoremap [Toggle]G :<C-u>GitGutterToggle<CR>

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
" ISetting    => 現在の状態を表示
" ISetting t4 => tab で幅4
" ISetting s2 => space で幅2
function! ISetting(setting, force_retab)
  if !empty(a:setting)
    if strlen(a:setting) == 2
      let expandtab = a:setting[0]
      let shiftwidth = a:setting[1]
    else
      echo "Arg Error"
      return
    endif
    if expandtab ==? "t"
      setlocal noexpandtab
    elseif expandtab ==? "s"
      setlocal expandtab
    endif

    let bk_tabstop = &l:tabstop

    let &l:shiftwidth = shiftwidth
    let &l:softtabstop = shiftwidth
    let &l:tabstop = shiftwidth

    " 強制的に Retab をかける
    if a:force_retab
      exec 'Retab ' . bk_tabstop
    endif

    " IndentGuides を再描画させるため
    doautocmd WinEnter
  endif

  let current_indent_setting = "indent: " . ((&l:expandtab) ? "space" : "tab") . " " . &l:shiftwidth
  echo current_indent_setting
endfunction
command! -nargs=? -bang ISetting call ISetting(<q-args>, <bang>0)

" My retab
function! Retab(old_tabstop)
  let pos = getpos('.')
  let new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  silent execute '%s/\v%(^ *)@<= {' . a:old_tabstop . '}/' . new_indent . '/ge'
  silent retab
  call setpos('.', pos)
endfunction
command! -nargs=? Retab call Retab(empty(<q-args>) ? &l:tabstop : <q-args>)

" 矩形選択でなくても複数行入力をしたい
xnoremap <expr> I MultipleInsersion('I')
xnoremap <expr> A MultipleInsersion('A')
function! MultipleInsersion(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else
    return a:next_key
  endif
endfunction

" 短縮入力
abbreviate Ocaml OCaml

" 番号リスト
" see: https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC--7
xnoremap <silent> <C-A> :ContinuousNumber<CR>
command! -count ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . "\<C-A>"|call cursor('.', c)|endfor

" 今開いているファイルを削除
function! DeleteMe(force)
  if a:force || !&modified
    let filename = expand('%')
    bdelete!
    call delete(filename)
  else
    echomsg 'File modified'
  endif
endfunction
command! -bang -nargs=0 DeleteMe call DeleteMe(<bang>0)

" 今開いているファイルをリネーム
function! RenameMe(newFileName)
  let currentFileName = expand('%')
  execute 'saveas ' . a:newFileName
  call delete(currentFileName)
endfunction
command! -nargs=1 RenameMe call RenameMe(<q-args>)

" () まで消すを便利に
onoremap ) t)
onoremap ( T(

" 行末の空白とか最終行の空行を削除
function! RemoveUnwantedSpaces()
  %s/\s\+$//e
  while 1
    let lastline = getline('$')
    if lastline =~ '^\s*$' && line('$') != 1
      $delete
    else
      break
    endif
  endwhile
endfunction
command! -nargs=0 RemoveUnwantedSpaces call RemoveUnwantedSpaces()

" fFtT 用
noremap ; <Nop>
noremap ;; ;
sunmap ;
noremap , <Nop>
noremap ,, ,
sunmap ,
"}}}

" ColorScheme {{{
if s:is_windows
  let s:indent_guides_guifg = "#c0c0c0"
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
