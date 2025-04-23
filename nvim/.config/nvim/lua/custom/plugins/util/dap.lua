return {
  'mfussenegger/nvim-dap',
  lazy = true,
  keys = {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ebug: Toggle [B]reakpoint',
    },

    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = '[D]edbug: [C]ontinue',
    },

    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = '[D]ebeug: Run to [C]ursor',
    },

    {
      '<leader>dT',
      function()
        require('dap').terminate()
      end,
      desc = '[D]ebug: [T]erminate',
    },
  },
  config = function()
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'executable',
      command = 'codelldb', -- or if not in $PATH: "/absolute/path/to/codelldb"
    }
  end,
}
