if exists('g:loaded_watupdoc') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

function s:watupdoc()
  if !has_key(g:, 'watupdoc')
    let g:watupdoc = watupdoc#new()
    call g:watupdoc.init()
  endif
  return g:watupdoc
endfunction

nnoremap <silent> <Plug>(WatupdocOpen) :call <SID>watupdoc.open_urls()<CR>

augroup WatupdocGroup
  autocmd BufWritePost * call s:watupdoc.update_buffer(str2nr(expand('<abuf>')))
  autocmd CursorMoved * call s:watupdoc.display_info()
augroup END

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_watupdoc = 1
