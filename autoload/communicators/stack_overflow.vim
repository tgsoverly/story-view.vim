function! g:communicators#stack_overflow#new()
  let obj = {}

  " The fetch_stories function is not covered unnder automated testing
  function! obj.fetch_stories(file_path)
    let relative_file_path = utils#path#get_relative_path(a:file_path)
    let sq = "'"
    let command = 'curl -X GET -s '
    let headers = '-H "X-API-Access-Token: $WATUPDOC_STACK_OVERFLOW_ACCESS_TOKEN" '
    let url = '"https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&site=stackoverflow&filter=withbody'
    let query = '&q="' . relative_file_path . '"'
    let team = '&team=stackoverflow.com%2fc%2f$WATUPDOC_STACK_OVERFLOW_TEAM'
    let key = '&key=$WATUPDOC_STACK_OVERFLOW_KEY"'
    let unzip = ' | gunzip '
    let response = system(command . headers . url . query . team . key . unzip)

    return response
  endfunction

  " This takes the response from fetch_stories and puts it in the standard
  " format for display.  It is seperated to give the ability to test.
  function! obj.normalize_response(response, file_path, link_parsers)
      let response = json_decode(a:response)

      let relative_file_path = utils#path#get_relative_path(a:file_path)

      let normalized_stories = []

      if has_key(response, 'items')
        for item in response.items
          let lines = []
          for link in a:link_parsers
            call extend(lines, link.get_lines(relative_file_path, item.body))
          endfor

          let uniq_lines = filter(copy(lines), 'index(lines, v:val, v:key+1)==-1')
          if len(uniq_lines) > 0
            call add(normalized_stories, {'name':item.title . ' (Stack Overflow)', 'url':item.link, 'lines': uniq_lines})
          endif
        endfor
      endif

      return normalized_stories
  endfunction

  return obj
endfunction
