describe 'communicators#clubhouse_io.fetch_stories'
  it 'returns the correct value'
    SKIP 'Run this test to get the output of the communicator'
    let clubhouse_io = communicators#clubhouse_io#new()

    Expect clubhouse_io.fetch_stories('fixtures/file.js') to_be_true
  end
end

describe 'communicators#clubhouse_io.normalize_response'
  context 'empty clubhouse response'
    it 'returns empty response'
      let clubhouse_io = communicators#clubhouse_io#new()
      let github = link_parsers#github#new()

      let response = system('cat fixtures/communicators/clubhouse_io/empty.json')
      let relative_file_path = 'fixtures/file.js'

      Expect clubhouse_io.normalize_response(response, relative_file_path, [github]) == []
    end
  end

  context 'not empty clubhouse response'
    it 'returns normalized stories'
      let clubhouse_io = communicators#clubhouse_io#new()
      let github = link_parsers#github#new()

      let response = system('cat fixtures/communicators/clubhouse_io/one.json')
      let relative_file_path = 'fixtures/file.js'

      Expect clubhouse_io.normalize_response(response, relative_file_path, [github]) == [{"name":"Github Link", "url":'https://app.clubhouse.io/test/story/17', "lines" :[1]}]
    end
  end

  context 'not empty clubhouse comment response'
    it 'returns normalized stories'
      let clubhouse_io = communicators#clubhouse_io#new()
      let github = link_parsers#github#new()

      let response = system('cat fixtures/communicators/clubhouse_io/comment.json')
      let relative_file_path = 'fixtures/file.js'

      Expect clubhouse_io.normalize_response(response, relative_file_path, [github]) == [{"name":"Github Link", "url":'https://app.clubhouse.io/test/story/17', "lines" :[1]}]
    end
  end
end
