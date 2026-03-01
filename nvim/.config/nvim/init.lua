require 'config.base'
require 'config.keymap'
require 'config.custom'

require 'kickstart.init'

local project_config = vim.fn.getcwd() .. "./.nvim.lua"
if vim.fn.filereadable(project_config) == 1 then
	dofile(project_config)
end
