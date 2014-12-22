" ### fundamental ### {{{
" プラグイン管理
NeoBundleFetch 'Shougo/neobundle.vim'

" アレをアレする
NeoBundle 'Shougo/unite.vim', {
\ 'lazy': 1,
\ 'commands': [
\   {'name': 'Unite', 'complete': 'customlist,unite#complete_source'},
\   'UniteWithProjectDir', 'UniteWithBufferDir', 'UniteWithInput', 'UniteWithInputDirectory',
\   'UniteWithCursorWord', 'UniteBookmarkAdd',
\ ]}

" 非同期実行
NeoBundle 'Shougo/vimproc', {
\ 'disabled': g:is_windows,
\ 'build': {
\   'unix': 'make -f make_unix.mak',
\ }}

" Plugin for Plugin
NeoBundle 'vim-jp/vital.vim', {
\ 'lazy': 1,
\ }

" Vim help 日本語版
NeoBundle 'vim-jp/vimdoc-ja', {
\ 'lazy': 0,
\ }
" }}}

" ### 入力系 ### {{{
" 入力補完
NeoBundle 'Shougo/neocomplete', {
\ 'lazy': 1,
\ 'insert': 1,
\ }

" スニペット補完
NeoBundle 'Shougo/neosnippet', {
\ 'depends': 'Shougo/neosnippet-snippets',
\ 'lazy': 1,
\ 'insert': 1,
\ 'filetypes': 'neosnippet',
\ }
snoremap <C-l> <Esc>a

" Zen-Coding
NeoBundle 'mattn/emmet-vim', {
\ 'lazy': 1,
\ 'filetypes': ['html', 'eruby', 'jsp', 'xml'],
\ }

" 対応する括弧の自動入力
NeoBundle 'cohama/lexima.vim', {
\ 'lazy': 0,
\ }

" }}}

" ### text-object ### {{{
NeoBundle 'kana/vim-textobj-user', {
\ 'lazy': 1,
\ }

" インデントが同じ物をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-indent', {
\ 'lazy': 0,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': [['ox', 'ii', 'ai', 'iI', 'aI']],
\ }

" 全体をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-entire', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': [['ox', 'ie', 'ae']],
\ }

" 関数をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-function', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': [['ox', 'if', 'af']],
\ 'filetypes': ['vim', 'c'],
\ }

" JavaScript の関数をテキストオブジェクト化を追加
NeoBundle 'thinca/vim-textobj-function-javascript', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-function',
\ 'filetypes': 'javascript',
\ }

" 任意の文字に囲まれた部分をテキストオブジェクト化
NeoBundle 'thinca/vim-textobj-between', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': '<Plug>',
\ }

" Ruby のメソッドをテキストオブジェクト化
NeoBundle 't9md/vim-textobj-function-ruby', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-function',
\ 'filetypes': 'ruby',
\ }

" 行内の文字をテキストオブジェクト化
NeoBundle 'kana/vim-textobj-line', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': [['ox', 'il', 'al']],
\ }

" 最後に編集した領域
NeoBundle 'gilligan/textobj-lastpaste', {
\ 'lazy': 0,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': '<Plug>',
\ }

" コメントをテキストオブジェクト化
NeoBundle 'thinca/vim-textobj-comment', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-textobj-user',
\ 'mappings': [['ox', 'ic', 'ac']],
\ }

" }}}

" ### operator ### {{{
" テキストオブジェクトのまわりに文字を挿入
NeoBundle 'tpope/vim-surround', {
\ 'lazy': 1,
\ 'mappings': [['n', 'ys', 'ds', 'cs'], ['x', 'S']],
\ }

" コメント化
NeoBundle 'tpope/vim-commentary', {
\ 'lazy': 1,
\ 'mappings': [['nx', 'gc', 'gC']],
\ }

NeoBundle 'kana/vim-operator-user', {
\ 'lazy': 1,
\ }

" ヤンクしたものと対象の文字列を置き換える
NeoBundle 'kana/vim-operator-replace', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-operator-user',
\ 'mappings': '<Plug>',
\ }

" snake_case -> CamelCase にするオペレータ
NeoBundle 'tyru/operator-camelize.vim', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-operator-user',
\ 'mappings': '<Plug>',
\ }

NeoBundle 'tommcdo/vim-exchange', {
\ 'lazy': 1,
\ 'mappings': ['<Plug>(Exchange)', '<Plug>(ExchangeLine)', '<Plug>(ExchangeClear)'],
\ }

" }}}

" ### 編集を便利にする ### {{{
" 整形
NeoBundle 'h1mesuke/vim-alignta', {
\ 'lazy': 1,
\ 'commands': ['Alignta', 'Align'],
\ }

" . による繰り返しをプラグインの機能にも適用
NeoBundle 'kana/vim-repeat', {
\ 'lazy': 0,
\ }

" }}}

" ### ファイル操作など ### {{{
" ディレクトリ、ファイルをツリー表示
NeoBundle 'scrooloose/nerdtree', {
\ 'lazy': 1,
\ 'commands': ['NERDTreeToggle', 'NERDTreeToggle'],
\ }

" sudo で保存
NeoBundle 'sudo.vim', {
\ 'lazy': 1,
\ }

" ファイラ
NeoBundle 'Shougo/vimfiler', {
\ 'lazy': 1,
\ 'commands': [
\   {'name': 'VimFiler', 'complete': 'customlist,vimfiler#complete'},
\   'VimFilerTab', 'VimFilerSplit', 'VimFilerBufferDir'],
\ 'mappings': '<Plug>',
\ 'explorer': 1,
\ }

" 一時ファイル的な
NeoBundle 'Shougo/junkfile.vim', {
\ 'lazy': 1,
\ 'unite_sources': ["junkfile", "junkfile/new"],
\ }

" 規則に従ってファイルを開く
NeoBundle 'kana/vim-altr', {
\ 'lazy': 1,
\ 'mappings': ['<M-1>', '<M-2>'],
\ }

" }}}

" ### 移動 ### {{{
" CamelCase や snake_case での単語移動
NeoBundle 'bkad/CamelCaseMotion', {
\ 'lazy': 0,
\ }

" カーソルを任意の位置にジャンプさせる
NeoBundle 'Lokaltog/vim-easymotion', {
\ 'lazy': 1,
\ 'mappings': [['nox', '[EasyMotion]']],
\ }

" 記号とかに邪魔されずに w, b, e できる
NeoBundle 'kana/vim-smartword', {
\ 'lazy': 1,
\ 'mappings': '<Plug>',
\ }

" 選択したところを検索
NeoBundleLazy 'thinca/vim-visualstar', {
\ 'mappings': '<Plug>',
\ }

NeoBundle 'deris/columnjump', {
\ 'lazy': 1,
\ 'mappings': '<Plug>',
\ }

" Vim で hoge#fuga() みたいなやつのジャンプ
NeoBundle 'sgur/vim-gf-autoload', {
\ 'lazy': 1,
\ 'depends': 'kana/vim-gf-user',
\ 'filetypes': ['vim'],
\ }

NeoBundle 'haya14busa/incsearch.vim', {
\ 'lazy': 0,
\ }
" }}}

" ### 見た目、カラースキーム ### {{{
" インデントの量を可視化
NeoBundle 'nathanaelkane/vim-indent-guides'


" エラー箇所をハイライトする
NeoBundle 'cohama/vim-hier', {
\ 'lazy': 1,
\ }

" エラーの原因をコマンドウィンドウに出力
NeoBundle 'dannyob/quickfixstatus', {
\ 'lazy': 1,
\ }

" 複数箇所をハイライト
NeoBundleLazy 't9md/vim-quickhl', {
\ 'mappings': '<Plug>',
\ }

" フォントサイズ変更
NeoBundleLazy 'thinca/vim-fontzoom', {
\ 'gui': 1,
\ 'mappings': '<Plug>',
\ 'commands': 'Fontzoom',
\ }

" インサートモード時に行番号の色を反転
NeoBundle 'cohama/vim-insert-linenr'
" }}}

" ### Git ### {{{
" 直接 Git コマンド実行など
NeoBundle 'tpope/vim-fugitive', {
\ 'lazy': 0,
\ }

" gitk っぽいものを Vim で
NeoBundle 'cohama/agit.vim', {
\ 'lazy': 1,
\ 'commands': 'Agit',
\ }

" git のステータスを行の横に表示
NeoBundle 'airblade/vim-gitgutter', {
\ 'lazy': 1,
\ 'commands': ['GitGutterToggle'],
\ }

" git のコミットメッセージをバルーンで表示
NeoBundle 'rhysd/git-messenger.vim', {
\ 'lazy': 1,
\ 'mappings': '<Plug>',
\ }
" }}}

" ### Language ### {{{
NeoBundle 'tpope/vim-rails'

NeoBundle 'vim-ruby/vim-ruby', {
\ 'lazy': 1,
\ 'filetypes': ['ruby', 'eruby'],
\ }

NeoBundle 'kchmck/vim-coffee-script', {
\ 'lazy': 1,
\ 'filetypes': 'coffee',
\ }

NeoBundle 'derekwyatt/vim-scala', {
\ 'lazy': 1,
\ }

NeoBundle 'groenewege/vim-less', {
\ 'lazy': 1,
\ }

NeoBundle 'pangloss/vim-javascript', {
\ 'lazy': 1,
\ 'filetypes': 'javascript',
\ }

NeoBundle 'marijnh/tern_for_vim', {
\ 'lazy': 1,
\ 'disabled': !executable('npm'),
\ 'filetypes': 'javascript',
\ 'build_commands': 'npm install',
\ }

NeoBundle 'leafgarland/typescript-vim'

NeoBundle 'cohama/the-ocamlspot.vim', {
\ 'lazy': 1,
\ 'disabled': !executable('ocamlspot'),
\ 'filetypes': 'ocaml',
\ }

NeoBundle 'https://bitbucket.org/anyakichi/vim-ocp-index', {
\ 'lazy': 1,
\ 'disabled': !executable('hg') || !executable('ocp-index'),
\ 'filetypes': 'ocaml',
\ }

NeoBundle 'kana/vim-filetype-haskell', {
\ 'lazy': 1,
\ 'filetypes': 'haskell',
\ }

NeoBundle 'eagletmt/ghcmod-vim', {
\ 'lazy': 1,
\ 'disabled': !executable('ghc-mod'),
\ 'filetypes': 'haskell',
\ }

NeoBundle 'eagletmt/neco-ghc', {
\ 'lazy': 1,
\ 'disabled': !executable('ghc-mod'),
\ 'filetypes': 'haskell',
\ }

NeoBundle 'ujihisa/ref-hoogle', {
\ 'lazy': 1,
\ 'disabled': !executable('hoogle'),
\ 'filetypes': 'haskell',
\ }

NeoBundle 'ujihisa/unite-haskellimport', {
\ 'lazy': 1,
\ 'disabled': !executable('hoogle'),
\ 'filetypes': 'haskell',
\ }

NeoBundle 'eagletmt/unite-haddock', {
\ 'lazy': 1,
\ 'filetypes': 'haskell',
\ }

NeoBundle 'jvoorhis/coq.vim', {
\ 'lazy': 1,
\ }

NeoBundle 'vim-scripts/CoqIDE', {
\ 'lazy': 1,
\ 'filetypes': 'coq',
\ }

NeoBundle 'jdonaldson/vaxe', {
\ 'lazy': 1,
\ }

NeoBundle 'fsharp/fsharpbinding', {
\ 'lazy': 1,
\ 'filetypes': 'fsharp',
\ 'rtp': 'vim'
\ }

" }}}

" ### 何かを実行 ### {{{
" Vim で動く shell
NeoBundle 'Shougo/vimshell', {
\ 'lazy': 1,
\ 'commands': [{'name': 'VimShell',
\               'complete': 'customlist,vimshell#complete'},
\              'VimShellExecute', 'VimShellInteractive',
\              'VimShellTerminal', 'VimShellPop'],
\ 'mappings': '<Plug>',
\ }

" その場で実行
NeoBundle 'thinca/vim-quickrun', {
\ 'lazy': 1,
\ 'mappings': [['n', '\r']],
\ 'commands': ['QuickRun'],
\ }

" 独自のモードを設定
NeoBundle 'kana/vim-submode', {
\ 'lazy': 1,
\ 'mappings': [['n', '<C-W>+', '<C-W>-', '<C-W>>', '<C-W><']],
\ }

" Vim から URL を開く
NeoBundle 'tyru/open-browser.vim', {
\ 'lazy': 1,
\ 'mappings': '<Plug>(openbrowser-',
\ }

" vim-quickrun hooks 集
NeoBundle "osyo-manga/shabadou.vim", {
\ 'lazy': 1,
\ }

" 非同期でシンタックスチェック
NeoBundle 'osyo-manga/vim-watchdogs', {
\ 'lazy': 1,
\ 'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'cohama/vim-hier', 'dannyob/quickfixstatus'],
\ 'filetypes': ['cpp', 'ruby', 'javascript', 'haskell', 'python', 'perl', 'php', 'lua', 'c', 'scala', 'sh', 'zsh', 'sass', 'scss', 'coffee', 'ocaml', 'haxe'],
\ }

" ref を見る
NeoBundle 'thinca/vim-ref', {
\ 'lazy': 1,
\ 'mappings': 'K',
\ }

" markdown をブラウザでプレビュー
NeoBundle 'kannokanno/previm', {
\ 'lazy': 1,
\ 'depends': ['tyru/open-browser.vim'],
\ 'commands': ['PrevimOpen']
\ }

" Vim script のテスティングフレームワーク
NeoBundle 'thinca/vim-themis', {
\ 'lazy': 0,
\ }

" すでに起動している Vim があればそれを使う
NeoBundle 'thinca/vim-singleton', {
\ 'lazy': 0,
\ 'gui': 1,
\ }

" 文法チェッカー
NeoBundle 'rhysd/vim-grammarous', {
\ 'lazy': 1,
\ 'commands' : 'GrammarousCheck'
\ }
" }}}

" ### Unite Sourceses ### {{{
NeoBundle 'Shougo/unite-outline', {
\ 'lazy': 1,
\ }

NeoBundle 'thinca/vim-unite-history', {
\ 'lazy': 1,
\ 'unite_sources': ['history/command', 'history/search']
\ }

NeoBundle 'osyo-manga/unite-highlight', {
\ 'lazy': 1,
\ }

NeoBundle 'Shougo/neomru.vim'

NeoBundle 'zhaocai/unite-scriptnames', {
\ 'lazy': 1,
\ }
" }}}

" ### Miscellaneous ### {{{
" コードを Gist に送るためのプラグイン
NeoBundle 'mattn/gist-vim', {
\ 'lazy': 1,
\ 'depends': 'mattn/webapi-vim',
\ 'commands': 'Gist'
\ }

" Scouter
NeoBundle 'thinca/vim-scouter', {
\ 'lazy': 1,
\ }

" スクリプトローカルな関数を呼ぶ
NeoBundle 'thinca/vim-scall', {
\ 'lazy': 1,
\ 'functions': ['S', 'Scall']
\ }

" プロジェクトローカルな vimrc を作成
NeoBundle 'thinca/vim-localrc'

" pretty print
NeoBundle 'thinca/vim-prettyprint', {
\ 'lazy': 1,
\ 'commands': ['PP', 'PrettyPrint'],
\ 'functions': ['PP', 'PrettyPrint'],
\ }

" help 自動生成
NeoBundle 'LeafCage/vimhelpgenerator', {
\ 'lazy': 1,
\ 'commands': ['VimHelpGenerator', 'HelpIntoMarkdown']
\ }

" }}}
