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
      vim.fn.system(python_path .. " -m debugpy --version")
      if vim.v.shell_error ~= 0 then
        python_path = vim.g.python3_host_prog
        require("noice").redirect(function()
          local notify = require("notify")
          -- notify("debugpy not found for " .. python_path, "warn", { title = "nvim-dap-python" })
        end)
      end
      require("dap-python").setup(python_path)
      -- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
      -- must work in the shell
    end
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
    config = function ()
      -- signs
      vim.fn.sign_define('DapBreakpoint',          { text='', priority=50, texthl='debugBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='', priority=50, texthl='Debug', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped',             { text='', priority=50, texthl='debugBreakpoint', linehl='NvimDapStopped', numhl='' })
      vim.fn.sign_define('DapLogPoint',            { text='', priority=50, texthl='Debug', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointRejected',  { text='R', priority=50, texthl='Debug', linehl='', numhl='' })
      local DebugHl = vim.api.nvim_get_hl(0, { name = "Debug" })
      local debugBreakpointHl = vim.api.nvim_get_hl(0, { name = "debugBreakpoint" })
      vim.api.nvim_set_hl(0, "Debug",           { fg = DebugHl.fg, bg = "none" })
      vim.api.nvim_set_hl(0, "debugBreakpoint", { fg = debugBreakpointHl.fg, bg = "none" })
      vim.api.nvim_set_hl(0, "NvimDapStopped",  { bg = "#223366" })

      -- commands
      vim.api.nvim_create_user_command("Dap", "DapNew Launch\\ file", {})
      vim.api.nvim_create_user_command("DapStart", "DapNew Launch\\ file", {})
      vim.api.nvim_create_user_command("DapBreakpoint", "DapToggleBreakpoint", {})
      vim.api.nvim_create_user_command("DapNext", "DapStepInto", {})
      vim.api.nvim_create_user_command("DapQuit", "DapTerminate", {})

      -- keymaps
      local keymap_opts = { noremap = true, silent = true, nowait = false }
      vim.keymap.set("n", "<Leader>ds", "<CMD>DapNew Launch\\ file<CR>", keymap_opts)
      vim.keymap.set("n", "<Leader>db", "<CMD>DapToggleBreakpoint<CR>", keymap_opts)
      vim.keymap.set("n", "<Leader>dn", "<CMD>DapStepInto<CR>", keymap_opts)
      vim.keymap.set("n", "<Leader>dc", "<CMD>DapContinue<CR>", keymap_opts)
      vim.keymap.set("n", "<Leader>dq", "<CMD>DapTerminate<CR>", keymap_opts)
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
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
    lazy = true,
    commit = "9578276",
    opts = {
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
      display_callback = function(variable, _, _, _, options)
        -- by default, strip out new line characters
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value:gsub("%s+", " ")
        else
          return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
        end
      end,
      -- experimental features:
      all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                             -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    },
  },
}
