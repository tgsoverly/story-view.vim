function! g:story_view#new()
  let obj = {}
  let obj._last_called = {}
  let obj._displayed_stories = {}
  let obj._cleared_info = 0

  " Default values
  let obj.delay = 60000.0
  let obj.communicators = [g:communicators#clubhouse_io#new()]
  let obj.link_parsers = [g:link_parsers#github#new()]

  function! obj.init()
    highlight DeepFreezeHighlight ctermbg=17
    call sign_define('DeepFreezeSign', {'text' : '^>', 'linehl' : 'DeepFreezeHighlight'})
  endfunction

  " Main interface with VIM
  function! obj.update_buffer(buffer_number)
    let l:file_path = utils#path#get_file_path(a:buffer_number)

    if !self.should_fetch_stories(l:file_path)
      return 0
    endif

    let l:stories = self.fetch_stories(l:file_path)
    call self.update_ui(l:file_path, l:stories)

    return 1
  endfunction

  function! obj.display_info()
    let l:file_path = expand('%:p')
    let l:line_number = getpos('.')[1]

    if mode(1) isnot# 'n'
        return
    endif

    let l:message = self.get_file_line_info(l:file_path, l:line_number)
    if l:message !=# ''
      try
        " This was taken from the denseanalysis/ale plugin.
        exec "norm! :echomsg l:message\n"
        catch /^Vim\%((\a\+)\)\=:E523/
            let l:winwidth = winwidth(0)

            if l:winwidth < strdisplaywidth(l:message)
                let l:message = l:message[:l:winwidth - 4] . '...'
            endif

            exec 'echomsg l:message'
        catch /E481/
      endtry
      let self._cleared_info = 0
    elseif !self._cleared_info
      let self._cleared_info = 1
      execute 'echo'
    endif
  endfunction

  function! obj.open_urls()
    let l:file_path = expand('%:p')
    let l:line_number = getpos('.')[1]

    if mode(1) isnot# 'n'
        return
    endif

    let l:urls = self.get_file_line_urls(l:file_path, l:line_number)
    for url in l:urls
      call system('open "' . url . '"')
    endfor
  endfunction


  function! obj.should_fetch_stories(file_path)
    if !has_key(self._last_called, a:file_path)
      return 1
    endif

    let l:lastcall = self._last_called[a:file_path]
    let l:elapsed = reltimefloat(reltime()) - l:lastcall
    if type(l:lastcall) == 0 || l:elapsed > self.delay / 1000.0
      return 1
    else
      return 0
    endif
  endfunction

  function! obj.fetch_stories(file_path)
    call self.add_call_time(a:file_path)
    let l:stories = []

    for communicator in self.communicators
      let l:response = communicator.fetch_stories(a:file_path)
      call extend(l:stories, communicator.normalize_response(l:response, a:file_path, self.link_parsers))
    endfor

    return l:stories
  endfunction

  function! obj.update_ui(file_path, stories)
    for story in a:stories
      for line in story.lines
        call sign_place(line, 'deepFreeze', 'DeepFreezeSign', a:file_path, {'lnum' : line})
      endfor
    endfor
    let self._displayed_stories[a:file_path] = a:stories
  endfunction

  function! obj.get_file_line_info(file_path, line)
    let l:line_info = []
    if has_key(self._displayed_stories, a:file_path)
      for story in self._displayed_stories[a:file_path]
        for line in story.lines
          if line == a:line
            call add(l:line_info, story.name)
          endif
        endfor
      endfor
    endif

    return join(l:line_info, ', ')
  endfunction

  function! obj.get_file_line_urls(file_path, line)
    let l:line_urls = []
    if has_key(self._displayed_stories, a:file_path)
      for story in self._displayed_stories[a:file_path]
        for line in story.lines
          if line == a:line
            call add(l:line_urls, story.url)
          endif
        endfor
      endfor
    endif

    return l:line_urls
  endfunction


  function! obj.add_call_time(file_path, ...)
    let l:timestamp = get(a:, 1, reltimefloat(reltime()))
    let self._last_called[a:file_path] = l:timestamp
  endfunction

  function! obj.get_call_time(file_path)
    return self._last_called[a:file_path]
  endfunction

  return obj
endfunction
