describe 'utils#path#get_relative_path'
  it 'returns array and sets call time'
    execute 'e fixtures/file.js'

    let file_path = utils#path#get_file_path(bufnr('%'))
    Expect utils#path#get_relative_path(file_path) == '/fixtures/file.js'
  end
end

describe 'utils#path#get_file_path'
  it 'returns array and sets call time'
    execute 'e fixtures/file.js'

    let file_path = utils#path#get_file_path(bufnr('%'))
    Expect utils#path#get_relative_path(file_path)[0] =~ '/'
  end
end
