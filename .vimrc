" Initialization {{{
" My autocmd group
augroup myautocmd
  autocmd!
augroup END

" condition variables
let g:is_windows = has('win32') || has('win64')
let g:is_unix = has('unix')
let g:is_gui = has('gui_running')
let g:is_terminal = !g:is_gui
let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8') && !(exists('g:discard_unicode') && g:discard_unicode != 0)

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

" 漢には不要
set noswapfile

" on だと guard が複数回実行されてしまう問題がある
set nowritebackup

" 既存のファイルを開くときはとりあえず utf-8
set fileencodings=utf-8,default,ucs-bom,latin1
" }}}

" ### View ### {{{
" 色数
set t_Co=256

" コマンドラインの行数
set cmdheight=3

" 現在行の色を変える
set cursorline
let g:cursorline_flg = 1 " cursorline はウィンドウローカルなのでグローバルなフラグを用意しておく
let g:cursorcolumn_flg = 0

" ステータス行を常に表示
set laststatus=2

" 再描画しない (gitv.vim で推奨されている)
set lazyredraw

" 不可侵文字を可視化
set list
set listchars=tab:>\ "

" 行番号を表示 (相対)
set number relativenumber

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

" シンプル・イズ・ベストなステータスライン
set statusline=%f%M%R%H%W%q%{&ff=='unix'?'':',['.&ff.']'}%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}%=%(\|%3p%%%)

" 補完メニューで preview しない
set completeopt-=preview
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
if g:is_unicode
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
set history=2000
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

" いろんなコマンドの後にカーソルを先頭に移動させない
set nostartofline
" }}}
" }}}

" Plugin Bundles {{{
" NeoBundle の設定
filetype plugin indent off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" ### fundamental ### {{{
" プラグイン管理
NeoBundleFetch 'Shougo/neobundle.vim'

" アレをアレする
NeoBundle 'Shougo/unite.vim'

" 非同期実行
if g:is_unix
  NeoBundle 'Shougo/vimproc', {
        \     'build': {
        \        'unix': 'make -f make_unix.mak'
        \     }
        \   }
endif

" Plugin for Plugin
NeoBundleLazy 'vim-jp/vital.vim', {
\ 'autoload' : {
\   'function_prefix' : 'vital'
\ }}
" }}}

" ### 入力系 ### {{{
" 入力補完
" NeoBundleLazy 'Shougo/neocomplcache', {
NeoBundleLazy 'Shougo/neocomplete', {
\ 'autoload' : {
\   'insert' : 1
\ }}

" スニペット補完
NeoBundleLazy 'Shougo/neosnippet', {
\ 'depends': 'Shougo/neosnippet-snippets',
\ 'autoload' : {
\   'insert' : 1,
\   'filetypes' : 'snippet',
\ }}

" Zen-Coding
NeoBundleLazy 'mattn/emmet-vim', {
\ 'autoload' : {
\   'filetypes' : ['html', 'eruby', 'jsp', 'xml'],
\   'commands' : ['<Plug>ZenCodingExpandNormal']
\ }}

" 対応する括弧の自動入力 (kana 神の fork)
NeoBundle 'cohama/vim-smartinput'

" ruby の def end とか自動入力
NeoBundle 'cohama/vim-smartinput-endwise'

" echo area に情報を表示
" NeoBundleLazy 'Shougo/echodoc', {
" \ 'augroup' : 'echodoc',
" \ 'autoload' : {
" \   'insert' : 1
" \ }}

" }}}

" ### text-object ### {{{
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

" 行内の文字をテキストオブジェクト化
NeoBundleLazy 'kana/vim-textobj-line', {
\ 'depends' : 'kana/vim-textobj-user',
\ 'autoload' : {
\   'mappings' : [['ox', 'il'], ['ox', 'al']]
\ }}

" 最後に編集した領域
NeoBundleLazy 'gilligan/textobj-lastpaste', {
\ 'autoload' : {
\   'mappings' : [['ox', 'iP']]
\ }}

" コメントをテキストオブジェクト化
NeoBundleLazy 'thinca/vim-textobj-comment', {
\ 'autoload' : {
\   'mappings' : [['ox', 'ic'], ['ox', 'ac']]
\ }}
" }}}

" ### operator ### {{{
" テキストオブジェクトのまわりに文字を挿入
NeoBundleLazy 'tpope/vim-surround', {
\ 'autoload' : {
\   'mappings' : [['n', 'ys'], ['n', 'ds'], ['n', 'cs'], ['x', 'S']]
\ }}

" コメント化
NeoBundleLazy 'tpope/vim-commentary', {
\ 'autoload' : {
\   'mappings' : [['nx', 'gc'], ['nx', 'gC']]
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

" ### 編集を便利にする ### {{{
" 整形
NeoBundleLazy 'h1mesuke/vim-alignta', {
\ 'autoload' : {
\   'commands' : ['Alignta', 'Align']
\ }}

" . による繰り返しをプラグインの機能にも適用
NeoBundleLazy 'kana/vim-repeat', {
\ 'autoload' : {
\   'function_prefix' : 'repeat'
\ }}
" }}}

" ### ファイル操作など ### {{{
" ディレクトリ、ファイルをツリー表示
NeoBundleLazy 'scrooloose/nerdtree', {
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
\                 'VimFilerBufferDir', 'VimFilerCurrentDir', 'VimFilerSplit', 'VimFilerExplorer', 'VimFilerTab', 'VimFilerCreate'],
\   'mappings' : ['<Plug>(vimfiler_switch)']
\ }}

" 一時ファイル的な
NeoBundleLazy 'Shougo/junkfile.vim', {
\ 'autoload' : {
\   'commands' : ["JunkfileOpen"],
\   'unite_sources' : ["junkfile", "junkfile/new"]
\ }}

" 規則に従ってファイルを開く
NeoBundleLazy 'kana/vim-altr', {
\ 'autoload' : {
\   'mappings' : [['n', "\<M-1>"], ['n', "\<M-2>"]]
\ }}
" }}}

" ### 移動 ### {{{
" CamelCase や snake_case での単語移動
NeoBundleLazy 'cohama/CamelCaseMotion', {
\ 'autoload' : {
\   'mappings' : ['<Plug>CamelCaseMotion_w', '<Plug>CamelCaseMotion_b', '<Plug>CamelCaseMotion_e']
\ }}

" カーソルを任意の位置にジャンプさせる
NeoBundleLazy 'EasyMotion', {'autoload' : {
\ 'mappings' : map(['w', 'b', 'e', 'ge', 'W', 'B', 'E', 'gE', 'f', 'F', 't', 'T'], '["n", "[EasyMotion]" . v:val]')
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

NeoBundleLazy 'deris/columnjump', {
\ 'autoload': {
\   'mappings': ['<Plug>(columnjump-backward)', '<Plug>(columnjump-forward)']
\ }}
" }}}

" ### 見た目、カラースキーム ### {{{
" インデントの量を可視化
NeoBundle 'nathanaelkane/vim-indent-guides'

" エラー箇所をハイライトする
NeoBundleLazy 'cohama/vim-hier'

" エラーの原因をコマンドウィンドウに出力
NeoBundleLazy 'dannyob/quickfixstatus'

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

" フォントサイズ変更
NeoBundleLazy 'thinca/vim-fontzoom', {
\ 'gui' : 1,
\ 'autoload' : {
\   'mappings': ['<Plug>(fontzoom-larger)', '<Plug>(fontzoom-smaller)'],
\   'commands': ['Fontzoom']
\ }}

" インサートモード時に行番号の色を反転
NeoBundle 'cohama/vim-insert-linenr'
" }}}

" ### Git ### {{{
" 直接 Git コマンド実行など
NeoBundle 'tpope/vim-fugitive', {
\ 'augroup': 'fugitive',
\ }

" gitk っぽいものを Vim で
NeoBundleLazy 'gregsexton/gitv', {
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
if executable('npm')
  NeoBundleLazy 'marijnh/tern_for_vim', {
  \ 'autoload': {
  \   'filetypes' : 'javascript'
  \ }}
endif
NeoBundle 'leafgarland/typescript-vim'
NeoBundleLazy 'cohama/the-ocamlspot.vim', {
\ 'autoload' : {
\   'filetypes' : 'ocaml'
\ }}
NeoBundleLazy 'kana/vim-filetype-haskell', {
\ 'autoload' : {
\   'filetypes' : 'haskell'
\ }}
NeoBundleLazy 'eagletmt/ghcmod-vim', {
\ 'autoload' : {
\   'filetypes' : 'haskell'
\ }}
NeoBundleLazy 'eagletmt/neco-ghc', {
\ 'autoload' : {
\   'filetypes' : 'haskell'
\ }}
let g:necoghc_enable_detailed_browse = 1
NeoBundleLazy 'ujihisa/ref-hoogle', {
\ 'autoload' : {
\   'filetypes' : 'haskell'
\ }}
NeoBundleLazy 'ujihisa/unite-haskellimport', {
\ 'autoload' : {
\   'filetypes' : 'haskell'
\ }}
" }}}

" ### 何かを実行 ### {{{
" Vim で動く shell
NeoBundleLazy 'Shougo/vimshell', {
\ 'autoload' : {
\   'commands' : [{ 'name' : 'VimShell',
\                   'complete' : 'customlist,vimshell#complete'},
\                 'VimShellExecute', 'VimShellInteractive',
\                 'VimShellTerminal', 'VimShellPop'],
\   'mappings' : ['<Plug>(vimshell_switch)']
\ }}

" その場で実行
NeoBundleLazy 'thinca/vim-quickrun', {
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
NeoBundleLazy "osyo-manga/shabadou.vim"

" 非同期でシンタックスチェック
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
\ 'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'cohama/vim-hier', 'dannyob/quickfixstatus'],
\ 'autoload' : {
\   'filetypes' : ['cpp', 'ruby', 'javascript', 'haskell', 'python', 'perl', 'php', 'lua', 'c', 'scala', 'sh', 'zsh', 'sass', 'scss', 'coffee', 'ocaml']
\ }}

" Vim で単体テスト
NeoBundleLazy 'kannokanno/vimtest', {
\ 'autoload' : {
\   'commands' : ['VimTest']
\ }}

" ref を見る
NeoBundle 'thinca/vim-ref'

" previm
NeoBundleLazy 'kannokanno/previm', {
\ 'depends' : ['tyru/open-browser.vim'],
\ 'autoload' : {
\   'commands' : ['PrevimOpen']
\ }}

" test
NeoBundleLazy 'kana/vim-vspec', {
\ 'autoload' : {
\   'filetypes' : ['vim']
\ }}

" すでに起動している Vim があればそれを使う
NeoBundle 'thinca/vim-singleton'
call singleton#enable()
" }}}

" ### Unite Souceses ### {{{
NeoBundleLazy 'Shougo/unite-outline', {
\ 'autoload' : {
\   'unite_sources' : ['outline']
\ }}

NeoBundleLazy 'thinca/vim-unite-history', {
\ 'autoload' : {
\   'unite_sources' : ['history/command', 'history/search']
\ }}

NeoBundleLazy 'osyo-manga/unite-highlight', {
\ 'autoload' : {
\   'unite_sources' : ['highlight']
\ }}
" }}}

" ### Miscellaneous ### {{{
" コードを Gist に送るためのプラグイン
NeoBundleLazy 'mattn/gist-vim', {
\ 'depends': 'mattn/webapi-vim',
\ 'autoload' : {
\   'commands' : 'Gist'
\ }}

" Scouter
NeoBundleLazy 'thinca/vim-scouter', {
\ 'autoload': {
\   'commands': 'Scouter'
\ }}

" スクリプトローカルな関数を呼ぶ
NeoBundleLazy 'thinca/vim-scall', {
\ 'autoload' : {
\   'functions' : ['S', 'Scall']
\ }}

" プロジェクトローカルな vimrc を作成
NeoBundle 'thinca/vim-localrc'

" pretty print
NeoBundleLazy 'thinca/vim-prettyprint', {
\ 'autoload' : {
\   'commands' : ['PP', 'PrettyPrint']
\ }}

" help 自動生成
NeoBundle 'LeafCage/vimhelpgenerator'
" NeoBundleLazy 'LeafCage/vimhelpgenerator', {
" \ 'autoload' : {
" \   'commands' : ['VimHelpGenerator', 'HelpIntoMarkdown']
" \ }}
" }}}
" }}}

" Plugin Settings {{{
" NeoBundle の設定 {{{
filetype plugin indent on
" Installation check.
NeoBundleCheck
" }}}

" neocomplete の設定 {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#max_list = 200
inoremap <expr><C-l> neocomplete#complete_common_string()
" inoremap <expr><C-h> neocomplete#smart_close_popup()
autocmd myautocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd myautocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd myautocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd myautocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#force_omni_patterns')
  let g:neocomplete#force_omni_patterns = {}
endif
let g:neocomplete#force_omni_patterns.javascript = ''
let g:neocomplete#force_omni_patterns.ruby = '[^. \t]\.\%(\h\w*\)\?\|\h\w*::'
" let g:neocomplete#force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
if !exists('g:neocomplete#omni_functions')
  let g:neocomplete#omni_functions = {}
endif
" let g:neocomplete#omni_functions.ruby = 'RSenseCompleteFunction'
" autocmd myautocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:neocomplete#dictionary#dictionaries = {
\ 'javascript': expand('~/.vim/dict/javascript.dict'),
\ 'ocaml' : expand('~/.vim/dict/ocaml.dict')
\ }

" 補完メニューの設定
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <C-u> pumvisible() ? neocomplete#cancel_popup() . "\<C-u>": "\<C-u>"
" }}}

" neosnippet の設定 {{{
let g:neosnippet#snippets_directory = expand('~/.vim/snippets')
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-l> <Plug>(neosnippet_expand_target)
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
let g:NERDTreeIgnore = ['\~$', '\.swp', '^\.$', '^\.\.$']
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 36
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 1
let g:NERDTreeMapCWD = "cD"
if !g:is_unicode
  let g:NERDTreeDirArrows = 0
endif
" }}}

" textobj-between の設定
let g:textobj_between_no_default_key_mappings = 1
omap i/ <Plug>(textobj-between-i)
xmap i/ <Plug>(textobj-between-i)
omap a/ <Plug>(textobj-between-a)
xmap a/ <Plug>(textobj-between-a)

" textobj-lastpaste
let g:textobj_lastpaste_no_default_key_mappings = 1
omap iP <Plug>(textobj-lastpaste-i)
xmap iP <Plug>(textobj-lastpaste-i)

" zencoding の設定 {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_leader_key = '<C-C>'
let g:user_emmet_settings = {
\ 'lang' : 'ja',
\ 'html' : {
\   'indentation' : '  '
\ }}
" }}}

" the-ocamlspot {{{
let s:the_ocamlspot_tree_ctermbg = '17'
let s:the_ocamlspot_tree_guibg = '#BBFFDD'
autocmd myautocmd ColorScheme * call s:the_ocamlspot_highlight()
function! s:the_ocamlspot_highlight()
  exec "highlight TheOCamlSpotTree gui=NONE cterm=NONE ctermfg=NONE guifg=NONE"
  \ . " ctermbg=" . s:the_ocamlspot_tree_ctermbg
  \ . " guibg=" . s:the_ocamlspot_tree_guibg
endfunction
" }}}

" vimshell の設定 {{{
autocmd myautocmd FileType vimshell call s:vimshell_my_settings()
function! s:vimshell_my_settings()
  let b:smartinput_disable_local = 1
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

" font zoom {{{
let g:fontzoom_no_default_key_mappings = 1
nmap <C-ScrollWheelUp>   <Plug>(fontzoom-larger)
nmap <C-ScrollWheelDown> <Plug>(fontzoom-smaller)
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
nnoremap [Git]F :<C-u>Git pull --rebase<CR>
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
nnoremap <silent> <M-d> :<C-u>Unite file file_mru bookmark file/new directory/new<CR>
nnoremap <silent> <M-m> :<C-u>Unite buffer file_mru bookmark<CR>
" see also smartinput settings
" cnoremap <expr> / (getcmdline() == '' && getcmdtype() == '/') ? "<BS>:Unite line<CR>" : "/"
" cnoremap <expr> ? (getcmdline() == '' && getcmdtype() == '?') ? "<BS>:Unite line:backward<CR>" : "?"
nnoremap [I :<C-U>UniteWithCursorWord line:backward<CR>
nnoremap ]I :<C-U>UniteWithCursorWord line:all<CR>
nnoremap <Leader>/ :<C-u>UniteWithInput line<CR><C-r>/<CR>
let g:unite_update_time = 100
let g:unite_enable_start_insert = 1
autocmd myautocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  let b:smartinput_disable_local = 1
  imap <silent><buffer> <C-q> <Plug>(unite_exit)
  map <silent><buffer><nowait> <Esc> <Plug>(unite_exit)
  noremap <silent><buffer><expr> s unite#smart_map("s", unite#do_action('vsplit'))
  noremap <silent><buffer><expr> S unite#smart_map("S", unite#do_action('split'))
  noremap <silent><buffer><expr> n unite#smart_map("n", unite#do_action('insert'))
  noremap <silent><buffer><expr> f unite#smart_map("f", unite#do_action('vimfiler'))
  noremap <silent><buffer><expr> F unite#smart_map("f", unite#do_action('tabvimfiler'))
  imap <silent><buffer> <C-n> <Plug>(unite_select_next_line)<Esc>
  nmap <silent><buffer> <C-n> <Plug>(unite_loop_cursor_down)
  nmap <silent><buffer> <C-p> <Plug>(unite_loop_cursor_up)
  map <silent><buffer> <M-n> <Plug>(unite_rotate_next_source)
  map <silent><buffer> <M-p> <Plug>(unite_rotate_previous_source)
  imap <silent><buffer> <Esc> <Plug>(unite_insert_leave)
endfunction
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt = ''
endif
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
  setlocal iskeyword+=/,-,.

  nmap <buffer> U ugg<CR>
  cnoremap <buffer><expr> <C-r><C-h> GitvGetCurrentHash()
  nnoremap <silent><buffer> J :<C-u>windo call GitToggleFolding()<CR>1<C-w>w
  nnoremap <buffer> . :<C-u> <C-r>=GitvGetCurrentHash()<CR><Home>
  nnoremap <buffer> [Git]rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]ri :<C-u>Git rebase -i <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR>
  nnoremap <buffer> ch :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR>
  nnoremap <buffer> [Git]a :<C-u>Git add -A<CR>
  nnoremap <buffer> [Git]rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]rm :<C-u>Git reset <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> [Git]rs :<C-u>Git reset --soft <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
  nnoremap <buffer> m :<C-u>Git merge --no-ff --no-commit<Space>
  nnoremap <buffer> cb :<C-u>Git checkout -b  <C-r>=GitvGetCurrentHash()<CR><Left><Left><Left><Left><Left><Left><Left><Left>
  nnoremap <buffer> fb :<C-u>Git branch -f  <C-r>=GitvGetCurrentHash()<CR><Left><Left><Left><Left><Left><Left><Left><Left>
  nnoremap <buffer> db :<C-u>Git branch -D <C-r><C-w>
  nnoremap <buffer> m :<C-u>Git merge <C-r><C-w>
endfunction
nnoremap [Git]k :<C-u>Gitv --all<CR>
nnoremap [Git]K :<C-u>Gitv!<CR>
let g:Gitv_TruncateCommitSubjects = 1
" }}}

" gitgutter の設定 {{{
let g:gitgutter_enabled = 0
nmap <silent> ]h :<C-u>execute v:count1 . "GitGutterNextHunk"<CR>
nmap <silent> [h :<C-u>execute v:count1 . "GitGutterPrevHunk"<CR>
nnoremap [Git]g :<C-u>GitGutterToggle<CR>
" }}}

" git-messenger {{{
nmap [Git]m <Plug>(git-messenger-commit-summary)
nmap [Git]M <Plug>(git-messenger-commit-message)
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

" coffeescript {{{
let coffee_make_options = '--bare'
let coffee_compiler = 'coffee'
let coffee_linter = 'coffeelint'
nnoremap <Leader>cc :CoffeeCompile<CR>
nnoremap <Leader>cm :CoffeeMake<CR>
nnoremap <Leader>cl :CoffeeLint<CR>
" }}}

" tern {{{
let g:tern_show_argument_hints = 'on_hold'
" }}}

" vimfiler {{{
nnoremap [VimFiler] <Nop>
nmap <Leader>F [VimFiler]
nnoremap [VimFiler]<CR> :<C-u>VimFiler<CR>
nnoremap [VimFiler]s :<C-u>VimFilerSplit<CR>
nnoremap <M-F> :<C-u>VimFilerSplit<CR>
nnoremap [VimFiler]t :<C-u>VimFilerTab<CR>
nnoremap [VimFiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap [VimFiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap [VimFiler]e :<C-u>VimFilerExplorer<CR>
nnoremap [VimFiler]E :<C-u>VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
nnoremap <M-f> :<C-u>VimFiler<CR>
nnoremap <M-F> :<C-u>VimFilerBufferDir -explorer -find<CR>
let g:vimfiler_safe_mode_by_default = 0
autocmd myautocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
  if g:is_unicode
    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = "\u25be" " filled inverse triangle
    let g:vimfiler_tree_closed_icon = "\u25b8" " filled right-pointed triangle
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_readonly_file_icon = "\u2717" " like X
    let g:vimfiler_marked_file_icon = "\u2713"   " checkmark like レ
  else
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '\' " filled inverse triangle
    let g:vimfiler_tree_closed_icon = '>' " filled right-pointed triangle
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_readonly_file_icon = "x" " like X
    let g:vimfiler_marked_file_icon = "O"   " checkmark like レ
  endif

  nmap <buffer><nowait> c <Plug>(vimfiler_copy_file)
  nmap <buffer><nowait> d <Plug>(vimfiler_delete_file)
endfunction
" }}}

" JunkFile の設定 {{{
let g:junkfile#edit_command = "tabedit"
" }}}

" altr {{{
let bundle = neobundle#get('vim-altr')
function! bundle.hooks.on_source(bundle)
  call altr#remove_all()
  call altr#define('plugin/%/*.vim', 'autoload/%/*.vim')
  call altr#define('plugin/%.vim', 'autoload/%.vim')
  call altr#define('ftplugin/*/%.vim', 'autoload/%.vim')
  call altr#define('after/ftplugin/*/%.vim', 'autoload/%.vim')
  call altr#define('%.ml', '%.mli')
  nnoremap <M-2> :<C-u>call altr#forward()<CR>
  nnoremap <M-1> :<C-u>call altr#back()<CR>
endfunction
" }}}

" CamelCaseMotion
map + [CamelCaseMotion]
map <silent> [CamelCaseMotion]w <Plug>CamelCaseMotion_w
map <silent> [CamelCaseMotion]b <Plug>CamelCaseMotion_b
map <silent> [CamelCaseMotion]e <Plug>CamelCaseMotion_e
sunmap [CamelCaseMotion]w
sunmap [CamelCaseMotion]b
sunmap [CamelCaseMotion]e

" EasyMotion {{{
nmap <CR> [EasyMotion]
let g:EasyMotion_leader_key = '[EasyMotion]'
let bundle = neobundle#get('EasyMotion')
function! bundle.hooks.on_post_source(bundle)
  sunmap [EasyMotion]w
  sunmap [EasyMotion]b
  sunmap [EasyMotion]e
  sunmap [EasyMotion]ge
  sunmap [EasyMotion]W
  sunmap [EasyMotion]B
  sunmap [EasyMotion]E
  sunmap [EasyMotion]gE
  sunmap [EasyMotion]f
  sunmap [EasyMotion]F
  sunmap [EasyMotion]t
  sunmap [EasyMotion]T
endfunction
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

" columnjump {{{
nmap <C-k> <Plug>(columnjump-backward)
xmap <C-k> <Plug>(columnjump-backward)
nmap <C-j> <Plug>(columnjump-forward)
xmap <C-j> <Plug>(columnjump-forward)
let g:columnjump_ignore_wrapped_lines = 1
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['_'] = {
\   'hook/close_buffer/enable_failure'            : 1,
\   'hook/close_buffer/enable_empty_data'         : 1,
\   'outputter'                                   : 'multi:buffer:quickfix',
\   'outputter/buffer/split'                      : 'botright 8',
\   'outputter/buffer/name'                       : 'QuickRunOut',
\   'outputter/buffer/close_on_empty'             : 1,
\   'outputter/quickfix/open_cmd'                 : '',
\   'runner'                                      : 'vimproc',
\   'runner/vimproc/updatetime'                   : 40
\ }
let g:quickrun_config['watchdogs_checker/_'] = {
\   'hook/close_unite_quickfix/enable_exit': 1,
\   'hook/back_window/enable_exit': 0,
\   'hook/quickfix_status_enable/enable_exit': 1,
\   'hook/hier_update/enable_exit': 1,
\   'hook/back_window/priority_exit': 1,
\   'hook/quickfix_status_enable/priority_exit': 2,
\   'hook/hier_update/priority_exit': 3,
\ }
let g:quickrun_config['ocaml/watchdogs_checker'] = {
\ 'type' : 'watchdogs_checker/ocamlc'
\ }
let g:quickrun_config['watchdogs_checker/make'] = {
\ 'command' : 'make',
\ 'exec' : '%c %o'
\ }
let g:quickrun_config['watchdogs_checker/ocamlc'] = {
\ 'command' : 'ocamlc',
\ 'exec'    : '%c -i %o - %s:p'
\ }
let g:quickrun_config['watchdogs_checker/ocamlc_annot'] = {
\ 'command' : 'ocamlc',
\ 'exec'    : '%c -annot -bin-annot -c %o - %s:p'
\ }
let g:quickrun_config['ruby.rspec'] = {
\   'command': 'bundle',
\   'exec': '%c exec rspec -f d %s'
\ }
let g:quickrun_config['ghc_make'] = {
\   'command': 'ghc',
\   'exec': '%c --make %s',
\   'outputter' : 'quickfix',
\   'outputter/quickfix' : 1,
\   'outputter/quickfix/open_cmd': 'cwindow',
\   'hook/back_window/enable_exit': 1,
\   'hook/back_window/priority_exit': 1
\ }
autocmd myautocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec | setlocal syntax=ruby
autocmd myautocmd BufWinEnter QuickRunOut setlocal winfixheight
nnoremap Q :<C-u>call CloseAnyOther()<CR>
function! CloseAnyOther()
  let w = 0
  let w:current_win = 1
  for w in reverse(range(1, winnr('$')))
    let ft = getwinvar(w, '&filetype')
    let bt = getwinvar(w, '&buftype')
    let bufnr = winbufnr(w)
    let name = bufname(bufnr)
    if (ft ==# 'quickrun' && name ==# 'QuickRunOut')
    \ || (ft ==# 'vimfiler')
    \ || (ft ==# 'vimshell')
    \ || (name =~# '^fugitive:')
    \ || (bt ==# 'help')
    \ || (bt ==# 'quickfix')
      execute w . 'wincmd w'
      q
      break
    endif
  endfor
  for w in range(1, winnr('$'))
    let was_current = getwinvar(w, 'current_win')
    if was_current
      execute w . 'wincmd w'
      unlet w:current_win
      break
    endif
  endfor
endfunction
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
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
\ 'scala' : 0
\ }
nnoremap <Leader>wr :<C-u>WatchdogsRun<CR>
" }}}

" smartinput {{{
let bundle = neobundle#get('vim-smartinput')
function bundle.hooks.on_source(bundle)
  call smartinput_endwise#define_default_rules()

  call smartinput#map_to_trigger('i', '<', '<', '<')
  call smartinput#map_to_trigger('i', '%', '%', '%')
  call smartinput#map_to_trigger('i', '*', '*', '*')
  call smartinput#map_to_trigger('i', 'l', 'l', 'l')

  call smartinput#define_rule({'at': '\$("\%#")', 'char': '<', 'input': '</><Left><Left>', 'filetype': ['javascript']})
  call smartinput#define_rule({'at': '<\%#', 'char': '%', 'input': '%<Space>%><Left><Left><Left>'})
  call smartinput#define_rule({'at': '{\%#', 'char': '%', 'input': '%%<Left>'})
  call smartinput#define_rule({'at': '{%\%#%}', 'char': '<BS>', 'input': '<BS><Del>'})
  call smartinput#define_rule({'at': '(\%#)', 'char': '*', 'input': '**<Left>', 'filetype': ['ocaml']})
  call smartinput#define_rule({'at': '(\*\%#\*)', 'char': '<BS>', 'input': '<BS><Del>', 'filetype': ['ocaml']})
  call smartinput#define_rule({'at': '\%#', 'char': "'", 'input': "'", 'filetype': ['ocaml', 'scala']})
  call smartinput#define_rule({'at': '\[\%#\]', 'char': '<Enter>', 'input': '<Enter><Enter><Up><Esc>"_S'})

  call smartinput#map_to_trigger('c', '/', '/', '/')
  call smartinput#map_to_trigger('c', ':', ':', ':')
  call smartinput#map_to_trigger('c', '<Space>', '<Space>', '<Space>')
  call smartinput#map_to_trigger('c', '?', '?', '?')
  call smartinput#map_to_trigger('c', 'A', 'A', 'A')
  call smartinput#map_to_trigger('c', 'B', 'B', 'B')
  call smartinput#map_to_trigger('c', 'C', 'C', 'C')
  call smartinput#map_to_trigger('c', 'D', 'D', 'D')
  call smartinput#map_to_trigger('c', 'F', 'F', 'F')
  call smartinput#map_to_trigger('c', 'G', 'G', 'G')
  call smartinput#map_to_trigger('c', 'I', 'I', 'I')
  call smartinput#map_to_trigger('c', 'J', 'J', 'J')
  call smartinput#map_to_trigger('c', 'L', 'L', 'L')
  call smartinput#map_to_trigger('c', 'M', 'M', 'M')
  call smartinput#map_to_trigger('c', 'N', 'N', 'N')
  call smartinput#map_to_trigger('c', 'O', 'O', 'O')
  call smartinput#map_to_trigger('c', 'P', 'P', 'P')
  call smartinput#map_to_trigger('c', 'R', 'R', 'R')
  call smartinput#map_to_trigger('c', 'S', 'S', 'S')
  call smartinput#map_to_trigger('c', 'U', 'U', 'U')
  call smartinput#map_to_trigger('c', 'c', 'c', 'c')
  call smartinput#map_to_trigger('c', 'l', 'l', 'l')
  call smartinput#map_to_trigger('c', 'm', 'm', 'm')

  call smartinput#define_rule({'at': '^\%#', 'char': '/', 'input': '<BS>:Unite line<CR>', 'mode': '/'})
  call smartinput#define_rule({'at': '^\%#', 'char': '?', 'input': '<BS>:Unite line<CR>', 'mode': '?'})
  call smartinput#define_rule({'at': '^\%#', 'char': ':', 'input': '<BS>:Unite history/command command<CR>', 'mode': ':'})

  call smartinput#define_rule({'at': 'Unite \%#', 'char': 'I', 'input': '<C-u>UniteWithInput<Space>', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite \%#', 'char': 'C', 'input': '<C-u>UniteWithCursorWord<Space>', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite \%#', 'char': 'B', 'input': '<C-u>UniteWithBufferDir<Space>', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': ':', 'input': '<BS>:', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'F', 'input': 'file ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*file \%#', 'char': 'R', 'input': '<BS>_rec ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*file \%#', 'char': 'M', 'input': '<BS>_mru ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*file_rec \%#', 'char': 'A', 'input': '<BS>/async ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*file_mru \%#', 'char': 'L', 'input': '<BS>:long ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'D', 'input': 'directory ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.\+ \%#', 'char': 'B', 'input': 'bookmark ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'S', 'input': 'source ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'M', 'input': 'mapping ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'O', 'input': 'out', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*out\%#', 'char': 'L', 'input': 'line ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*out\%#', 'char': 'P', 'input': 'put:', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'G', 'input': 'grep ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'J', 'input': 'junkfile junkfile/new ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.* \%#', 'char': 'N', 'input': 'neobundle ', 'mode': ':'})
  let log = '<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>-log -no-start-insert <Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>'
  call smartinput#define_rule({'at': 'Unite.*neobundle \%#', 'char': 'I', 'input': log . '<BS>/install ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*neobundle \%#', 'char': 'U', 'input': log . '<BS>/update ', 'mode': ':'})
  call smartinput#define_rule({'at': 'Unite.*neobundle/update \%#', 'char': 'U', 'input': '<BS>:! ', 'mode': ':'})

  call smartinput#define_rule({'at': 'RenameMe\%#', 'char': '<Space>', 'input': '<Space><C-r>%', 'mode': ':'})
  call smartinput#define_rule({'at': 'Gcommit --amend \%#', 'char': 'c', 'input': '-C HEAD', 'mode': ':'})
  call smartinput#define_rule({'at': 'Gcommit --amend \%#', 'char': 'C', 'input': '-C HEAD', 'mode': ':'})
  call smartinput#define_rule({'at': 'Git ca\%#', 'char': 'm', 'input': '<C-u>Gcommit --amend ', 'mode': ':'})
  call smartinput#define_rule({'at': '\%#', 'char': '<Enter>', 'input': '<Enter>zv:noh<Enter>', 'mode': '/?'})
  call smartinput#define_rule({'at': 'Ocam\%#', 'char': 'l', 'input': '<BS><BS><BS>Caml', 'mode': 'i:/?'})
endfunction
" }}}

" echodoc {{{
let g:echodoc_enable_at_startup = 1
" }}}

" vimhelpgenerator
let g:vimhelpgenerator_defaultlanguage = 'en'
let g:vimhelpgenerator_version = 'Version : 1.0.0'
let g:vimhelpgenerator_author = 'Author  : cohama / cohama@live.jp'


if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif
" }}}

" Settings and keymaps {{{
" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>

" Python による IBus の制御
let IM_CtrlIBusPython = 1

" ハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-n> :<C-u>nohlsearch<CR>

" terminal でも Meta キーを使いたい
if g:is_unix && g:is_terminal
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
nnoremap <silent> <M-L> :<C-u>call MoveTabPage("right")<CR>
nnoremap <silent> <M-H> :<C-u>call MoveTabPage("left")<CR>

" カーソル位置の単語を置換
nnoremap g/ :<C-u>%s/\C\<<C-R><C-w>\>//g<Left><Left>
nnoremap g? :<C-u>%s/\C\<<C-R><C-w>\>//gc<Left><Left><Left>
xnoremap g/ :s/\C\<<C-r><C-w>\>//g<Left><Left>
xnoremap g? :s/\C\<<C-R><C-w>\>//gc<Left><Left><Left>

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
if g:is_gui
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
xnoremap <expr> j (v:count == 0 && mode() !=# 'V') ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k (v:count == 0 && mode() !=# 'V') ? 'gk' : 'k'

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
  let cc = &cursorcolumn
  set nocursorline nocursorcolumn
  let height = winheight(0) / a:windiv
  let n = height / s:scroll_precision
  if n <= 0
    let n = 1
  endif
  let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
  let i = 0
  let scroll_command = a:dir == "down" ?
        \ "normal! " . n . "\<C-E>" . n ."j" :
        \ "normal! " . n . "\<C-Y>" . n ."k"
  while i < s:scroll_precision
    let i = i + 1
    execute scroll_command
    execute "sleep " . wait_per_one_move_ms . "m"
    redraw
  endwhile
  let &cursorline = cl
  let &cursorcolumn = cc
endfunction
nnoremap <silent> <C-d> :call CohamaSmoothScroll("down", 2, 1)<CR>
nnoremap <silent> <C-u> :call CohamaSmoothScroll("up", 2, 1)<CR>
nnoremap <silent> <C-f> :call CohamaSmoothScroll("down", 1, 2)<CR>
nnoremap <silent> <C-b> :call CohamaSmoothScroll("up", 1, 2)<CR>

" ビジュアルモードで選択した部分を置換
xnoremap / y:%s/\C<C-r>"//g<Left><Left>
xnoremap ? y:%s/\C<C-r>"//gc<Left><Left><Left>

" 行末までをヤンク
nnoremap Y y$

" コマンドモードのマッピング
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

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
nnoremap <expr> go "mz" . v:count . "o\<Esc>`z"
nnoremap <expr> gO "mz" . v:count . "O\<Esc>`z"

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
autocmd myautocmd WinEnter * if g:cursorcolumn_flg | setlocal cursorcolumn | endif
autocmd myautocmd WinLeave * if g:cursorcolumn_flg | setlocal nocursorcolumn | endif

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
nnoremap [Toggle]cc :<C-u>let g:cursorcolumn_flg = !g:cursorcolumn_flg<CR>:call Toggle("cursorcolumn")<CR>
nnoremap [Toggle]s :<C-u>call Toggle("spell", "local")<CR>
nnoremap [Toggle]n :<C-u>call ToggleNumber()<CR>
nnoremap [Toggle]r :<C-u>call ToggleRelativeNumber()<CR>
nnoremap [Toggle]h :<C-u>call Toggle("hlsearch")<CR>
nnoremap [Toggle]N :<C-u>NeoCompleteToggle<CR>
nnoremap [Toggle]I :<C-u>IndentGuidesToggle<CR>
nnoremap [Toggle]G :<C-u>GitGutterToggle<CR>
function! ToggleNumber()
  if &l:number && !&l:relativenumber
    setlocal nonumber
  else
    setlocal number
  endif
  setlocal norelativenumber
endfunction
function! ToggleRelativeNumber()
  if &l:number && &l:relativenumber
    setlocal nonumber
    setlocal norelativenumber
  else
    setlocal number
    setlocal relativenumber
  endif
endfunction

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
function! SuperRuler(count)
  let cnt = (a:count == 0) ? '' : a:count
  redir => ruler_out
    silent execute 'silent normal! ' . cnt . "\<C-g>"
  redir END
  " なぜか改行が入るので
  let super_ruler = ruler_out[2:] . "    | " . &fileformat . " | " . &fileencoding . " | " . &filetype . " | " . fugitive#statusline()[1:]
  echo super_ruler
endfunction
nnoremap <C-G> :<C-u>call SuperRuler(v:count)<CR>

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
nnoremap <F2> :<C-u>ISetting s2<CR>
nnoremap <F3> :<C-u>ISetting s3<CR>
nnoremap <F4> :<C-u>ISetting s4<CR>
nnoremap <S-F2> :<C-u>ISetting! s2<CR>
nnoremap <S-F3> :<C-u>ISetting! s3<CR>
nnoremap <S-F4> :<C-u>ISetting! s4<CR>
nnoremap <Leader><F2> :<C-u>ISetting! s2<CR>
nnoremap <Leader><F3> :<C-u>ISetting! s3<CR>
nnoremap <Leader><F4> :<C-u>ISetting! s4<CR>

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

" 自分自身と diff
function! DiffOrig()
  let orig_filetype = &filetype
  topleft vnew
  setlocal buftype=nofile
  read #
  1delete _
  let &filetype = orig_filetype
  diffthis
  wincmd p
  diffthis
endfunction
command! DiffOrig call DiffOrig()

" Quickfix のエラーに移動
nnoremap [e :<C-u>cprevious<CR>
nnoremap ]e :<C-u>cnext<CR>

" Presentation mode
function! Presentation()
  Fontzoom +8
  set cmdheight=3
  set laststatus=0
  set nonumber norelativenumber
  set showtabline=1
  set guioptions-=e
endfunction
command! -nargs=0 Presentation call Presentation()

" diff のときに便利
autocmd myautocmd TextChanged * call AutoDiffUpdate()
function! AutoDiffUpdate()
  if &diff
    diffupdate
  endif
endfunction

" diffthis をする
function! DiffThese()
  let win_count = winnr('$')
  if win_count == 2
    diffthis
    wincmd w
    diffthis
    wincmd w
  else
    echomsg "Too many windows."
  endif
endfunction
command! -nargs=0 DiffThese call DiffThese()

" ごめんなさい
nnoremap <M-S> :<C-u>browse save<CR>
nnoremap <M-O> :<C-u>browse edit<CR>

" 繰り返しを楽にする
xnoremap . :normal .<CR>

" haskell
function! OnHaskell()
  setl sw=4 sts=4 ts=4
  nnoremap <buffer> \S :<C-u>VimShellInteractive ghci <C-r>%<CR>
  nnoremap <buffer> \t :<C-u>GhcModType<CR>
  nnoremap <buffer><silent> <C-n> :<C-u>GhcModTypeClear<CR>:nohlsearch<CR>
  nnoremap <buffer> \R :<C-u>QuickRun ghc_make<CR>
endfunction
autocmd myautocmd FileType haskell call OnHaskell()

" digraph を打ちたい時もあるかもしれない
inoremap <C-g><C-l> <C-k>

" cdcurrent
command! CdCurrent cd %:p:h
command! LcdCurrent lcd %:p:h
"}}}

" ColorScheme {{{
if g:is_gui
  let s:indent_guides_guifg = "#c0c0c0"
  let s:indent_guides_odd_guibg = "#F9F9F9"
  let s:indent_guides_even_guibg = "#F0F0F0"
  set background=light
  autocmd myautocmd ColorScheme * highlight TheOCamlSpotTree gui=NONE guifg=NONE guibg=#BBFFDD
  colorscheme gui_cohama_light
else
  colorscheme cui_cohama
endif
" }}}
