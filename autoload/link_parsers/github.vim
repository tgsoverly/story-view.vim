function! g:link_parsers#github#new()
  let obj = {}

  " The fetch_stories function is not covered unnder automated testing
  function! obj.get_lines(relative_file_path, string)
    let regex = '\v' . escape(a:relative_file_path, '^$.*?/\[]')
    let start_matches = matchlist(a:string, regex . '#L(\d*)')

    if len(start_matches) == 0
      return []
    endif

    let end_matches = matchlist(a:string, regex . '#L\d*-L(\d*)')
    if len(end_matches) == 0
      return [str2nr(start_matches[1])]
    endif

    return range(start_matches[1], end_matches[1])
  endfunction

  return obj
endfunction
