describe 'link_parsers#github.get_lines'
  context "one line"
    it 'returns the correct lines numbers'
      let string = 'something fixtures/file.js#L1'
      let github = link_parsers#github#new()

      Expect github.get_lines('fixtures/file.js', string) == [1]
    end
  end

  context "multiple lines"
    it 'returns the correct lines numbers'
      let string = 'something fixtures/file.js#L1-L3'
      let github = link_parsers#github#new()

      Expect github.get_lines('fixtures/file.js', string) == [1, 2, 3]
    end
  end
end
