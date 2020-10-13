function! g:communicators#clubhouse_io#new()
  let obj = {}

  " The fetch_stories function is not covered unnder automated testing
  function! obj.fetch_stories(file_path)
    let relative_file_path = utils#path#get_relative_path(a:file_path)
    let sq = "'"
    let command = 'curl -X GET -s '
    let headers = '-H "Content-Type: application/json" -H "Clubhouse-Token: $WHATUPDOC_CLUBHOUSE_API_TOKEN" '
    let params = '-d ' . sq . '{ "query": "\"' . relative_file_path . '\"" }' . sq
    let url = '-L "https://api.clubhouse.io/api/v3/search" '
    let response = system(command . headers . params . url)

    return response
  endfunction

  " This takes the response from fetch_stories and puts it in the standard
  " format for display.  It is seperated to give the ability to test.
  function! obj.normalize_response(response, file_path, link_parsers)
    let response = json_decode(a:response)
    let relative_file_path = utils#path#get_relative_path(a:file_path)

    let normalized_stories = []

    if has_key(response, 'stories') && has_key(response.stories, 'data')
      for story in response.stories.data
        let lines = []
        for link in a:link_parsers
          call extend(lines, link.get_lines(relative_file_path, story.description))

          for comment in story.comments
            call extend(lines, link.get_lines(relative_file_path, comment.text))
          endfor
        endfor

        let uniq_lines = filter(copy(lines), 'index(lines, v:val, v:key+1)==-1')
        if len(uniq_lines) > 0
          call add(normalized_stories, {'name':story.name . ' (Clubhouse)', 'url':story.app_url, 'lines': uniq_lines})
        endif
      endfor
    endif

    return normalized_stories
  endfunction

  return obj
endfunction
