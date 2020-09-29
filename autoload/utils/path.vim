function! g:utils#path#get_relative_path(file_path)
  let base_dir = substitute(system('git rev-parse --show-toplevel'), '[[:cntrl:]]', '', 'g')
  let relative_file_path = substitute(a:file_path, escape(base_dir, '^$.*?/\[]'), '', '')

  return relative_file_path
endfunction

function g:utils#path#get_file_path(buffer_number)
    return expand('#' . a:buffer_number . ':p')
endfunction
