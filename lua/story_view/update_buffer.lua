local json = require("story_view.json")

local vim = vim

local times_called = 0

local function execr(cmd)
    local fh = assert(io.popen(cmd))
    local data = fh:read('*a')
    fh:close()
    return data
end

local update_buffer = {
  echo = function(buffer_number)
    local file_name = vim.api.nvim_call_function('expand', {'#' .. buffer_number .. ':p'})
    cards = execr("search-for-active-stories-for-file " .. file_name)

    local cards_table = json:decode(cards)

    vim.api.nvim_command('echom "Here we are! ' .. vim.inspect(cards_table) .. '"')
  end,

  highlight = function(buffer_number)
    local file_name = vim.api.nvim_call_function('expand', {'#' .. buffer_number .. ':p'})
    cards = os.execute("search-for-active-stories-for-file " .. file_name)
    vim.api.nvim_command('echom "! ' .. buffer_number .. '"')
  end,

  display_info = function(buffer_number)
    vim.api.nvim_command('echom "! ' .. buffer_number .. '"')
  end
}

return update_buffer
