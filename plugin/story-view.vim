if exists('g:loaded_story_view') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

lua require("story_view.init").setup()

" command to run our plugin
function! s:update_buffer(buffer_number)
  return luaeval(
        \ 'require("story_view.update_buffer").echo(_A.buffer_number)',
        \ {'buffer_number': a:buffer_number }
        \ )
endfunction

autocmd BufWrite * call s:update_buffer(str2nr(expand('<abuf>')))
autocmd CursorMoved * call s:update_buffer(str2nr(expand('<abuf>')))

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_story_view = 1
