if exists('g:loaded_watupdoc') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

let g:watupdoc = watupdoc()
call g:watupdoc.init()

nnoremap <silent> <Plug>(StoryViewOpen) :<C-W>call g:watupdoc.open_urls()<CR>
silent! nmap <unique> <C-W>      <Plug>(StoryViewOpen)

augroup StoryView
  autocmd BufWritePost * call g:watupdoc.update_buffer(str2nr(expand('<abuf>')))
  autocmd CursorMoved * call g:watupdoc.display_info()
augroup END

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_watupdoc = 1
