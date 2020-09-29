describe 'watupdoc.should_fetch_stories'
  context 'there is no previous entry'
    it 'returns true'
      let watupdoc = watupdoc#new()

      Expect watupdoc.should_fetch_stories('file_path') to_be_true
    end
  end

  context 'there is a previous entry under threshold'
    it 'returns true'
      let watupdoc = watupdoc#new()
      call watupdoc.add_call_time('file_path', reltimefloat(reltime()))

      Expect watupdoc.should_fetch_stories('file_path') to_be_false
    end
  end

  context 'there is a previous entry over threshold'
    it 'returns true'
      let watupdoc = watupdoc#new()
      call watupdoc.add_call_time('file_path', reltimefloat(reltime()) - watupdoc.delay)

      Expect watupdoc.should_fetch_stories('file_path') to_be_true
    end
  end
end

describe 'watupdoc.fetch_stories'
  it 'returns array and sets call time'
    let watupdoc = watupdoc#new()

    let watupdoc.communicators = [communicators#mock#new()]

    Expect watupdoc.fetch_stories('empty') == []
    Expect watupdoc.get_call_time('empty') != 0
  end
end

describe 'watupdoc.init'
  it 'sets the highlight'
    let watupdoc = watupdoc#new()

    call watupdoc.init()

    let name = execute('highlight DeepFreezeHighlight')
    Expect name =~ "Last set from"
  end

  it 'sets the sign'
    let watupdoc = watupdoc#new()

    call watupdoc.init()

    let sign_value = sign_getdefined('DeepFreezeSign')

    Expect sign_value[0].name =~ "DeepFreezeSign"
  end
end

describe 'watupdoc.update_buffer'
  it 'returns array and sets call time'
    let watupdoc = watupdoc#new()

    let watupdoc.communicators = [communicators#mock#new()]

    execute 'e fixtures/file.js'

    Expect watupdoc.update_buffer(bufnr("%")) to_be_true
    Expect getline(1) =~ "let variable"
    Expect watupdoc.get_file_line_info(utils#path#get_file_path(bufnr("%")), 1) == "story name"
  end
end
