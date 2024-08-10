return {
  "tpope/vim-fugitive",
  event = "CmdlineEnter",
  config = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "fugitive" },
      group = vim.api.nvim_create_augroup("custom_fugitive", { clear = true }),
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.bufhidden = "wipe"
        vim.opt_local.buflisted = false
        vim.opt_local.list = false
        vim.opt_local.equalalways = false
        vim.opt_local.spell = true
        vim.cmd("resize 10")
        -- local opts = { noremap = true, silent = true, nowait = true }
        -- vim.api.nvim_buf_set_keymap(0, "n", "<Leader>", "<Plug>(fugitive_-)", opts)
      end,
    })
    -- vim.keymap.set("n", "<Leader>gg", ":<C-u>G<CR>", { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<Leader>gd",
      "<CMD>Gvdiffsplit<CR><CMD>setl nobuflisted<CR>",
      { noremap = true, silent = true }
    )
  end,
}
