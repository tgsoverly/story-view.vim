if exists('g:loaded_story_view') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

let g:story_view = story_view#new()
call g:story_view.init()

nnoremap <silent> <Plug>(StoryViewOpen) :<C-W>call g:story_view.open_urls()<CR>
silent! nmap <unique> <C-W>      <Plug>(StoryViewOpen)

augroup StoryView
  autocmd BufWritePost * call g:story_view.update_buffer(str2nr(expand('<abuf>')))
  autocmd CursorMoved * call g:story_view.display_info()
augroup END

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_story_view = 1
