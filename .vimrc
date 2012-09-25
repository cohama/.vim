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

" Vim options {{{
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set cmdheight=3
set cursorline
set expandtab
set foldcolumn=1
set foldlevel=99
set foldmethod=marker
set foldtext=CohamaFoldText()
set formatoptions&
set formatoptions-=o
set formatoptions+=ctrqlm
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:>-
set nohidden
set nrformats-=octal
set number
set scrolloff=5
set shiftwidth=2
set showcmd
set smartcase
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set textwidth=0
set notagbsearch
set whichwrap&
set whichwrap+=h,l
set wildmenu
set wildmode=full
"}}}

" 色々な設定、キーマップなど{{{
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
nnoremap <silent> <C-T>W :tabclose!<CR>
nnoremap <silent> <C-T><C-O> :tabonly<CR>
nnoremap <silent> <C-T>o :tabonly<CR>
nnoremap <silent> <C-T><C-N> :tabnew<CR>
nnoremap <silent> <C-T>n :tabnew<CR>
nnoremap <silent> <C-T><C-e> :tabedit<Space>
nnoremap <silent> <C-T>e :tabedit<Space>
set showtabline=2

" ヤンクした文字列でカーソル位置の単語置き換え
nnoremap <silent> cy ce<C-R>0<Esc>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-R>0<Esc>:let@/=@1<CR>:noh<CR>

" カーソル位置の単語を置換
nnoremap g/ :%s/\<<C-R><C-w>\>//g<Left><Left>

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
nnoremap <silent> gh :help <C-r><C-w><CR>

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
autocmd CohamaAutoCmd BufRead,BufNewFile * match WhitespaceEOL /\s\+$/

" JavaScript を開いたとき
function! WhenJavaScriptOpened()
  setlocal foldmethod=syntax
endfunction
autocmd CohamaAutoCmd FileType javascript call WhenJavaScriptOpened()

" カーソルの桁座標が動かない gj, gk
nnoremap gj lhgj
nnoremap gk lhgk

" 検索結果で画面を真ん中に
nnoremap n nzz
nnoremap N Nzz

" インサートモードから出るときにカーソルを後退させない
function! FixedInsertLeave()
  " 行末だった場合は通常と同じく後退させる
  let cursorPos = col(".")
  let maxColumn = col("$")
  if cursorPos < maxColumn
    return "\<Esc>l"
  else
    return "\<Esc>"
  endif
endfunction
inoremap <silent><expr> <Esc> FixedInsertLeave()

" すごい :only
function! ExtendedOnly()
  tabonly
  only
endfunction
command! Only call ExtendedOnly()
cabbrev On Only

" help を開いたとき
function! WhenHelpOpened()
  normal H
  nnoremap <buffer> q :q<CR>
endfunction
autocmd CohamaAutoCmd FileType help call WhenHelpOpened()

" cohama smooth scroll
let s:scroll_time_ms = 100
let s:scroll_precision = 8
function! CohamaSmoothScroll(dir, windiv, factor)
  let height = winheight(0) / a:windiv
  let n = height / s:scroll_precision
  if n <= 0
    let n = 1
  endif
  let i = 0
  while i < s:scroll_precision
    let i = i + 1
    if a:dir == "d"
      execute "normal " . n . "" . n ."j"
    else
      execute "normal " . n . "" . n ."k"
    endif
    let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
    execute "sleep " . wait_per_one_move_ms . "m"
    redraw
  endwhile
  echo "CohamaSmoothScroll"
endfunction
nnoremap <silent> <C-d> :call CohamaSmoothScroll("d", 2, 1)<CR>
nnoremap <silent> <C-u> :call CohamaSmoothScroll("u", 2, 1)<CR>
nnoremap <silent> <C-f> :call CohamaSmoothScroll("d", 1, 2)<CR>
nnoremap <silent> <C-b> :call CohamaSmoothScroll("u", 1, 2)<CR>

" ビジュアルモードで選択した部分を置換
vnoremap / y:%s/<C-r>"//g<Left><Left>

" 行末までをヤンク
nnoremap Y y$

" コマンドモードのマッピング
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

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
nnoremap <silent> <C-t>dl :call CloseAllRightTabs()<CR>

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
nnoremap <silent> <C-t>dh :call CloseAllLeftTabs()<CR>

" オリジナル foldtext
function! CohamaFoldText()
  let line = getline(v:foldstart)
  let marker_removed = substitute(line, '{{{', '', 'g') "}}}
  let line_count = v:foldend - v:foldstart
  let lines = line_count > 1 ? ' lines' : ' line'
  let count_in_brace = substitute(marker_removed, '{\s*$', '{ ('.line_count.lines.') }', '')
  return count_in_brace
endfunction

" gitcommit を開いた時
function! WhenGitCommitOpened()
  nnoremap <buffer> q :x<CR>
  " commit cancel
  nnoremap <buffer> Q ggdG:x<CR>
endfunction
autocmd CohamaAutoCmd FileType gitcommit call WhenGitCommitOpened()

" 改行だけを入力する
nnoremap go o<Esc>
nnoremap gO O<Esc>

" Insert モードの時に行番号の色を変える
function! ToBrightLineNr()
  highlight LineNr ctermfg=16 ctermbg=250 guifg=#000000 guibg=#BCBCBC
  highlight CursorLineNr term=bold ctermbg=11 ctermbg=250 gui=bold guifg=#000000 guibg=#E6DB74
endfunction
function! ToDarkLineNr()
  highlight LineNr ctermfg=250 ctermbg=16 guifg=#BCBCBC guibg=#000000
  highlight CursorLineNr term=bold ctermfg=11 ctermbg=16 gui=bold guifg=#E6DB74 guibg=#000000
endfunction
autocmd CohamaAutoCmd InsertEnter * call ToBrightLineNr()
autocmd CohamaAutoCmd InsertLeave * call ToDarkLineNr()
"}}}

" Plugins {{{
" NeoBundle の設定
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
" NeoBundle で管理するプラグイン
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/Align'
NeoBundle 'tpope/vim-surround'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/vimproc', {
      \     'build': {
      \        'unix': 'make -f make_unix.mak'
      \     }
      \   }
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'gregsexton/gitv'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'groenewege/vim-less'
NeoBundle 'sudo.vim'
NeoBundle 'cohama/vim-javascript'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'camelcasemotion'
NeoBundle 'EasyMotion'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kana/vim-smartinput'
NeoBundleLazy 'wookiehangover/jshint.vim'

filetype plugin indent on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

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
autocmd CohamaAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd CohamaAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd CohamaAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd CohamaAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
" autocmd CohamaAutoCmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd CohamaAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

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

" Align の設定
map <Leader><Leader>rwp <Plug>RestoreWinPosn
map <Leader><Leader>swp <Plug>SaveWinPosn

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

" fugitive の設定
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gc :Gcommit -v<CR><C-w>H
nnoremap <Leader>gps :Git push<CR>
nnoremap <Leader>gpl :Git pull<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Space> :Git<Space>

" unite の設定
nnoremap <silent> <Leader>b :Unite buffer<CR>
nnoremap <silent> <Leader>ug :Unite grep -no-quit<CR>
nnoremap <silent> <Leader>f :Unite file_rec<CR>
nnoremap <silent> <Leader>ur :UniteResume<CR>
let g:unite_update_time = 100
let g:unite_enable_start_insert = 1
autocmd CohamaAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <silent><buffer> <C-q> <Plug>(unite_exit)
  map <silent><buffer> <Esc> <Plug>(unite_exit)
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

" coffeescript
let coffee_make_options = '--bare'
let coffee_compiler = 'coffee'
let coffee_linter = 'coffeelint'
nnoremap <Leader>cc :CoffeeCompile<CR>
nnoremap <Leader>cm :CoffeeMake<CR>
nnoremap <Leader>cl :CoffeeLint<CR>

" vimfiler
nnoremap <Leader>F :VimFiler<CR>
let g:vimfiler_safe_mode_by_default = 0
"}}}
