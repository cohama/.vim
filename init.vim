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

" 折り返しの際にインデントを考慮
if exists('+breakindent')
  set breakindent
endif
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

set nowrapscan
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
set fileencodings=utf-8,cp932

" Vim を終了しても undo の記録を残す
set undofile undodir=~/.vimundo
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

" 不可視文字を可視化
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
set statusline=%f%M%R%H%W%q%{&ff=='unix'?'':',['.&ff.']'}%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}%{QuickFixAlert()}%=%(\|%3p%%%)
function! QuickFixAlert() abort
  let warns = len(filter(getqflist(), {_, x -> x.type ==# 'W'})) + len(filter(getloclist(0), {_, x -> x.type ==# 'W'}))
  let errs = len(filter(getqflist(), {_, x -> x.type ==# 'E'})) + len(filter(getloclist(0), {_, x -> x.type ==# 'E'}))
  if warns == 0 && errs == 0
    return ''
  else
    let errs_s = errs == 0 ? '' : '!' . errs . (warns == 0 ? '' : ' ')
    let warns_s = warns == 0 ? '' : '?' . warns
    return ' [' . errs_s . warns_s . ']'
  endif
endfunction

set redrawtime=2000

" 補完メニューで preview しない
set completeopt-=preview

" diff で必ず垂直分割を使う
set diffopt& diffopt+=vertical
" }}}

" ### Input ### {{{
" バックスペースで削除できる文字
set backspace=indent,eol,start

" ヤンクなどで * レジスタにも書き込む
set clipboard=unnamed

" ヤンクなどで + レジスタにも書き込む
set clipboard+=unnamedplus

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

" spellcheck で日本語は対象外にする
set spelllang=en,cjk
" }}}
" }}}

" Plugin Bundles {{{
" NeoBundle の設定
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_cache_path = '~/.cache/dein'

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path, expand("<sfile>"))

  echo "load toml"
  call dein#load_toml('~/.config/nvim/dein.toml')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
"
" Settings and keymaps {{{
function ImActivateFunc(active)
  if a:active
    call system('fcitx-remote -o')
  else
    call system('fcitx-remote -c')
  endif
endfunction
" 「日本語入力固定モード」切り替えキー
if g:is_unix && executable('fcitx') && (g:is_gui || ($SSH_TTY == '' && $SSH_CLIENT == ''))
  set iminsert=0
  if !has('nvim')
    set imactivatefunc=ImActivateFunc
  endif
  " source ~/.vim/fcitx-python/fcitx-py.vim
  let g:im_fix_mode = 0
  function! s:toggle_im_fix_mode()
    let g:im_fix_mode = !g:im_fix_mode
    call ImActivateFunc(g:im_fix_mode)
    echo g:im_fix_mode ? 'IM Fix On' : 'IM Fix Off'
    return ''
  endfunction

  function! s:on_insertenter()
    if g:im_fix_mode
      call ImActivateFunc(1)
    endif
  endfunction
  autocmd myautocmd InsertEnter * silent! call s:on_insertenter()
  " autocmd myautocmd InsertLeave * silent! call ImActivateFunc(0)

  inoremap <C-j> <C-r>=<SID>toggle_im_fix_mode()<CR>
  nnoremap \<C-j> :<C-u>call <SID>toggle_im_fix_mode()<CR>
endif

" ハイライトを消す
nnoremap <silent> <C-n> :<C-u>nohlsearch<CR>:call Cancel()<CR>

function! Cancel()
  if dein#is_sourced('vim-exchange')
    XchangeClear
  endif
  if &ft ==# 'haskell' && dein#is_sourced('ghcmod-vim')
    GhcModTypeClear
  endif
endfunction

" タブページの設定
nnoremap <silent> <M-l> :<C-u>tabnext<CR>:pwd<CR>
nnoremap <silent> <M-h> :<C-u>tabprevious<CR>:pwd<CR>
nnoremap <silent> <M-n> :<C-u>tabnew<CR>
nnoremap <silent> <M-w> :<C-u>MyTabClose<CR>
nnoremap <silent> <M-W> :<C-u>tabonly<CR>
nnoremap <M-e> :<C-u>tabedit<Space>
function! MyTabClose()
  let tabpagenr = tabpagenr()
  if tabpagenr == 1
    tabclose
  else
    tabprevious
    execute 'tabclose ' . tabpagenr
  endif
endfunction
command! MyTabClose call MyTabClose()

" タブページの移動
nnoremap <silent> <M-L> :<C-u>tabmove +1<CR>
nnoremap <silent> <M-H> :<C-u>tabmove -1<CR>

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
nnoremap <silent> <Leader>v :<C-u>SmartDrop ~/.config/nvim/init.vim<CR>
nnoremap <silent> <Leader>gv :<C-u>SmartDrop ~/.config/nvim/ginit.vim<CR>

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
" ついでにメッセージを消す
nnoremap n :<BS>nzzzv
nnoremap N :<BS>Nzzzv

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

" 指定したタブをすべて閉じる
function! CloseTabsByNrList(closing_tabnr_list)
  let offset = 0
  for i in a:closing_tabnr_list
    exec 'tabclose ' . (str2nr(i) - offset)
    let offset = offset + 1
  endfor
endfunction

" 自分以外の特定のウィンドウを閉じる
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
    \ || (bt ==# 'nofile')
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

" help を開いたとき
function! WhenHelpOpened()
  wincmd L
  82wincmd |
  nnoremap <buffer> q ZZ
  setlocal winfixwidth
endfunction
autocmd myautocmd BufEnter * if &bt ==# 'help' | call WhenHelpOpened() | endif

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
nnoremap <silent><expr> <C-d> v:count == 0 ? ":call CohamaSmoothScroll('down', 2, 1)\<CR>" : "\<C-d>"
nnoremap <silent><expr> <C-u> v:count == 0 ? ":call CohamaSmoothScroll('up', 2, 1)\<CR>" : "\<C-u>"
nnoremap <silent><expr> <C-f> v:count == 0 ? ":call CohamaSmoothScroll('down', 1, 2)\<CR>" : "\<C-f>"
nnoremap <silent><expr> <C-b> v:count == 0 ? ":call CohamaSmoothScroll('up', 1, 2)\<CR>" : "\<C-b>"

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
  setlocal spell
  setlocal nocursorline
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
nnoremap <expr> dk line('.') == line('$') ? 'dk' : 'dkk'

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

endfunction
autocmd myautocmd ColorScheme * call ColorSchemeSettings()

" かしこい Home
" thanks to Shougo
function! SmartHome()
  let str_before_cursor = strpart(getline('.'), 0, col('.') - 1)
  let wrap_prefix = &wrap ? 'g' : ''
  if str_before_cursor !~ '^\s*$'
    return wrap_prefix . '^ze'
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

" set nopaste をできるだけ維持
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
" 代わりに改行でコメント継続
function! SetFormatOptions() abort
  setlocal formatoptions-=o
  setlocal formatoptions+=rmBj
endfunction
autocmd myautocmd BufWinEnter * call SetFormatOptions()

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
      if exists('#TextChanged')
        autocmd InsertLeave,CursorHold,TextChanged * update
      else
        autocmd InsertLeave,CursorHold * update
      endif
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
  let super_ruler = ruler_out[2:] . "    | " . &fileformat . " | " . &fileencoding . " | " . &filetype . " | " . VCSRepoInfo()
  echo super_ruler
endfunction

function! VCSRepoInfo() abort
  return fugitive#statusline()[1:]
endfunction
nnoremap <C-G> :<C-u>call SuperRuler(v:count)<CR>

" フォーマット変えて開き直す系
command! Utf8 edit ++enc=utf-8 %
command! Cp932 edit ++enc=cp932 %
command! Unix edit ++ff=unix %
command! Dos edit ++ff=dos %

command! AsUtf8 set fenc=utf-8|w

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
  let pos_save = getpos('.')
  try
    keeppatterns %s/\s\+$//e
    while 1
      let lastline = getline('$')
      if lastline =~ '^\s*$' && line('$') != 1
        $delete
      else
        break
      endif
    endwhile
  finally
    call setpos('.', pos_save)
  endtry
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

" Quickfix のときの <CR> を効かせる
autocmd myautocmd FileType qf nnoremap <buffer> <CR> <CR>

" Presentation mode
function! Presentation()
  Fontzoom +11
  set cmdheight=3
  set laststatus=0
  set number norelativenumber
  set showtabline=1
  set guioptions-=e
endfunction
command! -nargs=0 Presentation call Presentation()

" diff のときに便利
if exists('#TextChanged')
  autocmd myautocmd TextChanged * call AutoDiffUpdate()
endif
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
autocmd myautocmd BufNewFile,BufRead *.hsc setl ft=haskell
function! OnHaskell()
  setl sw=4 sts=4 ts=4
  setlocal omnifunc=necoghc#omnifunc
  nnoremap <buffer> \I :<C-u>VimShellInteractive ghci <C-r>%<CR>
  nnoremap <buffer> \S :<C-u>call vimshell#interactive#send(getline("."))<CR>
  xnoremap <buffer> \S "qygv:<C-u>call vimshell#interactive#send_string(@q)<CR>
  nnoremap <buffer> \D :<C-u>QuickRun ghc_doctest<CR>
  nnoremap <buffer> \t :<C-u>GhcModType<CR>
  nnoremap <buffer> \R :<C-u>QuickRun stack_build<CR>
  nnoremap <buffer> \uh :<C-u>Unite haskellimport<CR>
  nnoremap <buffer> \uH :<C-u>Unite haskellimport -input=<C-r><C-w><CR>
  nnoremap <buffer> \h :<C-u>WatchdogsRun watchdogs_checker/hlint<CR>
endfunction
autocmd myautocmd FileType haskell call OnHaskell()
function! SynHaskell()
  hi def link ConId Constant
endfunction
autocmd myautocmd Syntax haskell call SynHaskell()

" digraph を打ちたい時もあるかもしれない
inoremap <C-g><C-l> <C-k>

" cdcurrent
command! CdCurrent cd %:p:h
command! LcdCurrent lcd %:p:h

" 現在編集中のフルパスをクリップボードにコピー
command! CopyFullPath let @+ = expand('%:p')

" Markdown
autocmd myautocmd BufNewFile,BufRead *.md setl ft=markdown ts=4 sw=4 sts=4

" Coq
autocmd myautocmd ColorScheme * hi SentToCoq ctermbg=17 guibg=#000080
autocmd myautocmd FileType coq call MyCoqSettings()
function! MyCoqSettings()
  nnoremap <buffer><silent> \n :<C-u>CoqIDENext<CR>
  nnoremap <buffer><silent> \p :<C-u>CoqIDEUndo<CR>
  nnoremap <buffer><silent> \P :<C-u>CoqIDEUndo<CR>
endfunction

" Plugin のテストのために最小構成の Vim を起動する
command! -bang -nargs=* PluginTest call PluginTest(<bang>0, 0, <q-args>)
command! -bang -nargs=* PluginTestNeo call PluginTest(<bang>0, 1, <q-args>)
function! PluginTest(is_gui, is_nvim, extraCommand)
  let cmd = (g:is_gui || a:is_gui) ? '!gvim' : (a:is_nvim) ? 'terminal nvim' : '!vim'
  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * ' . a:extraCommand . '"'
  let plugintestrc = empty(findfile('.plugintest.vimrc', getcwd())) ? '' : ' -S .plugintest.vimrc'
  execute 'silent ' . cmd . ' -u ~/.vim/.min.vimrc -N --cmd "set rtp+=' . getcwd() . '"' . plugintestrc .  extraCommand
endfunction

" QuickFix Window
nnoremap \c :<C-u>lopen<CR>
nnoremap [e :<C-u>lprevious<CR>
nnoremap ]e :<C-u>lnext<CR>
autocmd myautocmd FileType qf nnoremap <buffer> <CR> <CR>

" Remember last current directory
function! SaveCurrentDirectory() abort
  try
    if !isdirectory(expand('~/.vimremember'))
      call mkdir(expand('~/.vimremember'), 'p')
    endif
    call writefile([getcwd()], expand('~/.vimremember/lastcwd'))
  catch /.*/
    call confirm(v:exception)
  endtry
endfunction
function! RememberLastCurrentDirectory() abort
  if filereadable(expand('~/.vimremember/lastcwd'))
    let cwd = readfile(expand('~/.vimremember/lastcwd'))
    cd `=cwd`
  endif
endfunction

if g:is_gui
  autocmd myautocmd VimLeavePre * call SaveCurrentDirectory()
  autocmd myautocmd VimEnter * call RememberLastCurrentDirectory()
endif


" Python
function! OnPython()
  if executable('autopep8')
    let &l:formatprg = "autopep8 --max-line-length 120 - 2> /dev/null"
  elseif executable('yapf')
    let &l:formatprg = "yapf 2> /dev/null"
  endif
  command! -bang PyFmt call PythonFormat(<bang>0)
  command! PyDoc call PythonGenerateDocstring()

  " nnoremap <buffer> <C-]> :<C-u>call jedi#goto()<CR>
endfunction
autocmd myautocmd FileType python call OnPython()

autocmd myautocmd BufNewFile,BufRead Pipfile set filetype=toml

function! PythonFormat(remove_unused_imports) abort
  if a:remove_unused_imports
    silent !pipenv run autoflake -i --remove-all-unused-imports %
  endif
  silent !pipenv run isort -w 120 %
  silent !pipenv run autopep8 --max-line-length 120 -i %
endfunction
autocmd myautocmd FileType python call OnPython()

function! PythonGenerateDocstring() abort
  let [bufnum, lnum, col, off] = getpos('.')
  let indent = indent(lnum + 1)
  let indent_spaces = repeat(' ', indent)
  execute 'r !pydocstring -f google % ' . lnum . ',' . col . '| sed -E -e "s/ (\(.+\)):/:/" -e 1d -e "s/./' . indent_spaces . '\0/" | cat -s'
  call setpos('.', [bufnum, lnum, col, off])
endfunction

" フォーカスを得たタイミングで全てのウィンドウサイズを揃える
autocmd myautocmd FocusGained * wincmd =

" varb
autocmd myautocmd BufNewFile,BufRead *.args setf varb
"}}}

" ColorScheme {{{
autocmd myautocmd ColorScheme * call AddMyHighlight()
function! AddMyHighlight() abort
  hi VirtualError ctermfg=8 gui=italic guifg=#753A5A
  hi VirtualWarning ctermfg=8 gui=italic guifg=#654458
endfunction


let g:my_background = get(g:, 'my_background', 'dark')
if g:my_background ==# 'light'
  colorscheme cohama_light
else
  colorscheme cohama
endif
command! Lighten let g:my_background = 'light' | colorscheme cohama_light
command! Darken  let g:my_background = 'dark' | colorscheme cohama

" gnvim 対応
if exists("g:gnvim")
  source ~/.config/nvim/ginit.vim
endif

" local 用 vimrc
if filereadable(fnamemodify("~/.config/nvim/.local.vim", ':p'))
  source ~/.config/nvim/.local.vim
endif

" }}}
