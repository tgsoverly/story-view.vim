describe 'communicators#stack_overflow.fetch_stories'
  it 'returns the correct value'
    SKIP 'Run this test to get the output of the communicator'
    let clubhouse_io = communicators#stack_overflow#new()

    Expect clubhouse_io.fetch_stories('fixtures/file.js') to_be_true
  end
end

describe 'communicators#stack_overflow.normalize_response'
  context 'empty stack overflow response'
    it 'returns empty response'
      let clubhouse_io = communicators#stack_overflow#new()
      let github = link_parsers#github#new()

      let response = system('cat fixtures/communicators/stack_overflow/empty.json')
      let relative_file_path = 'fixtures/file.js'

      Expect clubhouse_io.normalize_response(response, relative_file_path, [github]) == []
    end
  end

  context 'not empty stack overflow response'
    it 'returns normalized stories'
      let clubhouse_io = communicators#stack_overflow#new()
      let github = link_parsers#github#new()

      let response = system('cat fixtures/communicators/stack_overflow/one.json')
      let relative_file_path = 'fixtures/file.js'

      Expect clubhouse_io.normalize_response(response, relative_file_path, [github]) == [{"name":"Test question (Stack Overflow)", "url":'https://stackoverflow.com/c/team-name/questions/1/test-question', "lines" :[1]}]
    end
  end
end
