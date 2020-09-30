function! g:communicators#mock#new()
  let obj = {}

  function! obj.fetch_stories(file_path)
    if a:file_path =~# 'fixtures/file.js'
      return '[{"name": "story name", "url": "https://storyurl.com", "lines": [1, 2]}]'
    endif

    return '[]'
  endfunction

  function! obj.normalize_response(response, file_path, link_parsers)
    let parsed = json_decode(a:response)

    return parsed
  endfunction


  return obj
endfunction
