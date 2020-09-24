describe 'story_view.should_fetch_stories'
  context 'there is no previous entry'
    it 'returns true'
      let story_view = story_view#new()

      Expect story_view.should_fetch_stories('file_path') to_be_true
    end
  end

  context 'there is a previous entry under threshold'
    it 'returns true'
      let story_view = story_view#new()
      call story_view.add_call_time('file_path', reltimefloat(reltime()))

      Expect story_view.should_fetch_stories('file_path') to_be_false
    end
  end

  context 'there is a previous entry over threshold'
    it 'returns true'
      let story_view = story_view#new()
      call story_view.add_call_time('file_path', reltimefloat(reltime()) - story_view.delay)

      Expect story_view.should_fetch_stories('file_path') to_be_true
    end
  end
end

describe 'story_view.fetch_stories'
  it 'returns array and sets call time'
    let story_view = story_view#new()

    let story_view.communicators = [communicators#mock#new()]

    Expect story_view.fetch_stories('empty') == []
    Expect story_view.get_call_time('empty') != 0
  end
end

describe 'story_view.init'
  it 'sets the highlight'
    let story_view = story_view#new()

    call story_view.init()

    let name = execute('highlight DeepFreezeHighlight')
    Expect name =~ "Last set from"
  end

  it 'sets the sign'
    let story_view = story_view#new()

    call story_view.init()

    let sign_value = sign_getdefined('DeepFreezeSign')

    Expect sign_value[0].name =~ "DeepFreezeSign"
  end
end

describe 'story_view.update_buffer'
  it 'returns array and sets call time'
    let story_view = story_view#new()

    let story_view.communicators = [communicators#mock#new()]

    execute 'e fixtures/file.js'

    Expect story_view.update_buffer(bufnr("%")) to_be_true
    Expect getline(1) =~ "let variable"
    Expect story_view.get_file_line_info(utils#path#get_file_path(bufnr("%")), 1) == "story name"
  end
end
