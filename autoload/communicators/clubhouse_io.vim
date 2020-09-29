function! g:communicators#clubhouse_io#new()
  let obj = {}

  " The fetch_stories function is not covered unnder automated testing
  function! obj.fetch_stories(file_path)
    let l:relative_file_path = utils#path#get_relative_path(a:file_path)
    let sq = "'"
    let l:command = 'curl -X GET -s '
    let l:headers = '-H "Content-Type: application/json" -H "Clubhouse-Token: $CLUBHOUSE_API_TOKEN" '
    let l:params = '-d ' . sq . '{ "query": "' . l:relative_file_path . '" }' . sq
    let l:url = '-L "https://api.clubhouse.io/api/v3/search" '
    let l:response = system(l:command . l:headers . l:params . l:url)

    return l:response
  endfunction

  " This takes the response from fetch_stories and puts it in the standard
  " format for display.  It is seperated to give the ability to test.
  function! obj.normalize_response(response, file_path, link_parsers)
    let l:response = utils#json#parse(a:response)
    let l:relative_file_path = utils#path#get_relative_path(a:file_path)

    let l:normalized_stories = []

    if has_key(l:response, 'stories') && has_key(l:response.stories, 'data')
      for story in l:response.stories.data
        let l:lines = []
        for link in a:link_parsers
          call extend(l:lines, link.get_lines(l:relative_file_path, story.description))

          for comment in story.comments
            call extend(l:lines, link.get_lines(l:relative_file_path, comment.text))
          endfor
        endfor

        let l:uniq_lines = filter(copy(l:lines), 'index(l:lines, v:val, v:key+1)==-1')
        call add(l:normalized_stories, {'name':story.name, 'url':story.app_url, 'lines': l:uniq_lines})
        unlet l:uniq_lines
        unlet l:lines
      endfor
    endif

    return l:normalized_stories
  endfunction

  return obj
endfunction
