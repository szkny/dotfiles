return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function ()
      -- Python virtual env
      local venv_path = vim.fn.trim(vim.fn.system("poetry env info -p"))
      local python_path = ""
      if vim.v.shell_error == 0 then
        vim.env.VIRTUAL_ENV = venv_path
        vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
        python_path = venv_path .. "/bin/python"
      else
        python_path = vim.g.python3_host_prog
      end
      require("dap-python").setup(python_path)
      -- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
      -- must work in the shell
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function ()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    config = function ()
      require("nvim-dap-virtual-text").setup({
        enabled = true,                        -- enable this plugin (the default)
        enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,               -- show stop reason when stopped for exceptions
        commented = false,                     -- prefix virtual text with comment string
        only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
        all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        -- virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        virt_text_pos = 'inline',
        -- experimental features:
        all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                               -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function ()
      vim.fn.sign_define('DapBreakpoint',          { text='', texthl='debugBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='Debug', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped',             { text='→', texthl='debugBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapLogPoint',            { text='', texthl='Debug', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointRejected',  { text='R', texthl='Debug', linehl='', numhl='' })
    end
  }
}
