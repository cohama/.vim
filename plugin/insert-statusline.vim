scriptencoding=utf-8

" 挿入モード時、ステータスラインの色を変更
"
" このファイルの内容をそのまま.vimrc等に追加するか、
" pluginフォルダへこのファイルをコピーします。

" 挿入モード時の色指定
if !exists('g:hi_insert')
  let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
endif

" Linux等でESC後にすぐ反映されない場合、次行以降のコメントを解除してください
" if has('unix') && !has('gui_running')
"   " ESC後にすぐ反映されない場合
"   inoremap <silent> <ESC> <ESC>
"   inoremap <silent> <C-[> <ESC>
" endif

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

