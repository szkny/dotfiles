return {
  "szkny/Ipython",
  dependencies = { "szkny/SplitTerm" },
  cmd = {
    "Ipython",
    "VIpython",
  },
  ft = "python",
  config = function()
    vim.cmd([[
        let g:ipython_startup_options = [
                    \'--no-confirm-exit',
                    \'--colors=Linux',
                    \'--no-banner']
        let g:ipython_startup_command = [
                    \'from IPython import get_ipython',
                    \'mgc = get_ipython().run_line_magic',
                    \'mgc("load_ext", "autoreload")',
                    \'mgc("autoreload", "2")',
                    \'import pandas as pd',
                    \'pd.options.display.max_rows = 10',
                    \'pd.options.display.max_columns = 10',
                    \'import warnings',
                    \'warnings.filterwarnings(action="ignore",'
                    \.' module="sklearn", message="^internal gelsd")']
        let g:ipython_window_width = 10
    ]])
    local kopts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Leader><CR>", "<CMD>Ipython<CR>", kopts)
    vim.keymap.set("v", "<Leader><CR>", "<CMD>VIpython<CR>", kopts)
  end,
}
