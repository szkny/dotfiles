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
}
