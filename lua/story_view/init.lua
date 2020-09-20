local vim = vim

local init = {
  setup = function(o)
    vim.api.nvim_command('sign define story_view1 text=cs texthl=story_view1')
  end
}

return init
