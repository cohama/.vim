augroup myautocmd
  autocmd!
augroup END
let g:is_windows = has('win32') || has('win64')
let g:is_unix = has('unix')
let g:is_gui = has('gui_running')
let g:is_terminal = !g:is_gui
let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8') && !(exists('g:discard_unicode') && g:discard_unicode != 0)
scriptencoding utf-8
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set foldcolumn=1
set foldlevel=99
set foldmethod=marker
set foldtext=MyFoldText()
set hlsearch
nohlsearch
set ignorecase
set incsearch
set smartcase
set autoread
set nohidden
set noswapfile
set nowritebackup
set fileencodings=utf-8,default,ucs-bom,latin1
set undofile undodir=~/.vimundo
set t_Co=256
set cmdheight=3
set cursorline
set laststatus=2
set lazyredraw
set list
set listchars=tab:>\ "
set number relativenumber
set scrolloff=5
set showcmd
set textwidth=0
set showtabline=2
set display=lastline
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
set statusline=%f%M%R%H%W%q%{&ff=='unix'?'':',['.&ff.']'}%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}%{len(getqflist())==0?'':'\ [!]'}%=%(\|%3p%%%)
set completeopt-=preview
set backspace=indent,eol,start
set clipboard=unnamed
if has('unnamedplus')
  set clipboard+=unnamedplus
endif
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set virtualedit& virtualedit+=block
set nojoinspaces
if g:is_unicode
  let &showbreak = "\u21b3 "
else
  let &showbreak = "`-"
endif
set wildmenu
set wildmode=longest:full,full
set history=2000
set nrformats-=octal
set whichwrap&
set whichwrap+=h,l
set helplang=ja
set keywordprg=:help
set updatetime=1000
set nostartofline

" Plugins
if isdirectory(expand('~/.vim/bundle/vim-prettyprint'))
  set runtimepath+=~/.vim/bundle/vim-prettyprint/
endif

filetype plugin indent on

if g:is_unix && executable('fcitx') && (g:is_gui || ($SSH_TTY == '' && $SSH_CLIENT == ''))
  function ImActivateFunc(active)
    if a:active
      call system('fcitx-remote -o')
    else
      call system('fcitx-remote -c')
    endif
  endfunction
  autocmd myautocmd InsertLeave * silent! call ImActivateFunc(0)
endif

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

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-n> :<C-u>nohlsearch<CR>

nnoremap <silent> <M-l> :<C-u>tabnext<CR>
nnoremap <silent> <M-h> :<C-u>tabprevious<CR>
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

nnoremap <silent> <M-L> :<C-u>tabmove +1<CR>
nnoremap <silent> <M-H> :<C-u>tabmove -1<CR>
nnoremap g/ :<C-u>%s/\C\<<C-R><C-w>\>//g<Left><Left>
nnoremap g? :<C-u>%s/\C\<<C-R><C-w>\>//gc<Left><Left><Left>
xnoremap g/ :s/\C\<<C-r><C-w>\>//g<Left><Left>
xnoremap g? :s/\C\<<C-R><C-w>\>//gc<Left><Left><Left>

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

function! SmartDrop(tabedit_args)
  if expand('%') == "" && !&modified
    let drop_cmd = "drop "
  else
    let drop_cmd = "tab drop "
  endif
  silent execute drop_cmd . a:tabedit_args
endfunction
command! -nargs=* SmartDrop call SmartDrop(<q-args>)
if g:is_gui
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>:source $MYGVIMRC<CR>
else
  nnoremap <silent> <Leader>so :<C-u>source $MYVIMRC<CR>
endif
nnoremap <silent> <Leader>v :<C-u>SmartDrop ~/.vim/.vimrc<CR>

nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j (v:count == 0 && mode() !=# 'V') ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k (v:count == 0 && mode() !=# 'V') ? 'gk' : 'k'
nmap gj lhj
nmap gk lhk
nnoremap n :<BS>nzzzv
nnoremap N :<BS>Nzzzv

function! WhenHelpOpened()
  wincmd H
  82wincmd |
  nnoremap <buffer> q ZZ
  setlocal winfixwidth
endfunction

autocmd myautocmd FileType help call WhenHelpOpened()

xnoremap / y:%s/\C<C-r>"//g<Left><Left>
xnoremap ? y:%s/\C<C-r>"//gc<Left><Left><Left>
nnoremap Y y$
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" gitcommit, gitrebase を開いた時
autocmd myautocmd FileType gitcommit,gitrebase call WhenGitCommitOpened()
function! WhenGitCommitOpened()
  wincmd H
  82wincmd |
  nnoremap <buffer> q ZZ
  nnoremap <buffer> Q ggdGZZ
  setlocal winfixwidth
endfunction

nnoremap <expr> go "mz" . v:count . "o\<Esc>`z"
nnoremap <expr> gO "mz" . v:count . "O\<Esc>`z"

inoremap <C-e> <End>
inoremap <C-a> <C-o>^
inoremap <C-f> <Right>
inoremap <C-b> <Left>
nnoremap cc 0D

xnoremap D x0"_Dp==

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

syntax on

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
nnoremap <expr> L &wrap ? 'g$' : '$'
onoremap <expr> L &wrap ? 'g$' : '$'
xnoremap <expr> L &wrap ? 'g$h' : '$h'
nnoremap gV `[v`]

autocmd myautocmd InsertLeave * set nopaste

onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"
xnoremap x "_x

autocmd myautocmd FileType * setlocal formatoptions-=o

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
nnoremap [Toggle]s :<C-u>call Toggle("spell", "local")<CR>
nnoremap [Toggle]n :<C-u>call ToggleNumber()<CR>
nnoremap [Toggle]r :<C-u>call ToggleRelativeNumber()<CR>
nnoremap [Toggle]h :<C-u>call Toggle("hlsearch")<CR>
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

function! SuperRuler(count)
  let cnt = (a:count == 0) ? '' : a:count
  redir => ruler_out
    silent execute 'silent normal! ' . cnt . "\<C-g>"
  redir END
  " なぜか改行が入るので
  let super_ruler = ruler_out[2:] . "    | " . &fileformat . " | " . &fileencoding . " | " . &filetype
  echo super_ruler
endfunction

nnoremap <C-G> :<C-u>call SuperRuler(v:count)<CR>

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

function! RenameMe(newFileName)
  let currentFileName = expand('%')
  execute 'saveas ' . a:newFileName
  call delete(currentFileName)
endfunction

command! -nargs=1 RenameMe call RenameMe(<q-args>)

xnoremap . :normal .<CR>

command! CdCurrent cd %:p:h
command! LcdCurrent lcd %:p:h
command! CopyFullPath let @+ = expand('%:p')

autocmd myautocmd ColorScheme * hi MatchParen ctermfg=255 ctermbg=53 cterm=bold guifg=NONE guibg=#571C5E gui=bold
colorscheme desert
