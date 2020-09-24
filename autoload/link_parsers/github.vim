function! g:link_parsers#github#new()
  let obj = {}

  " The fetch_stories function is not covered unnder automated testing
  function! obj.get_lines(relative_file_path, string)
    let l:regex = '\v' . escape(a:relative_file_path, '^$.*?/\[]')
    let l:start_matches = matchlist(a:string, l:regex . '#L(\d*)')

    if len(l:start_matches) == 0
      return []
    endif

    let l:end_matches = matchlist(a:string, l:regex . '#L\d*-L(\d*)')
    if len(l:end_matches) == 0
      return [str2nr(l:start_matches[1])]
    endif

    return range(l:start_matches[1], l:end_matches[1])
  endfunction

  return obj
endfunction
