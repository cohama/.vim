function! neocomplcache#sources#javascript_complete#define()
  return s:source
endfunction

let s:source ={
      \ 'name': 'javascript_complete',
      \ 'kind': 'ftplugin',
      \ 'filetypes': {'javascript': 1}
      \ }

function! s:source.initialize()
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_pos(cur_text)
  " Get cursor word
  return match(a:cur_text, '\f*$')
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
  return []
endfunction

