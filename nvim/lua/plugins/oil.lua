return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  opts = {
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "n",
    },
    default_file_explorer = true,
    trash_command = "rip",
    use_default_keymaps = false,
    keymaps = {
      ["?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<2-LeftMouse>"] = "actions.select",
      ["<C-l>"] = "actions.select",
      ["<C-h>"] = "actions.parent",
      ["W"] = "actions.open_cwd",
      ["<Tab>"] = "actions.preview",
      ["q"] = "actions.close",
      ["R"] = "actions.refresh",
      ["H"] = "actions.toggle_hidden",
      ["I"] = "actions.toggle_hidden",
      ["<BS>"] = "actions.toggle_hidden",
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    vim.cmd([[
        fun! s:oil_init() abort
            setlocal nonumber
            setlocal nobuflisted
            setlocal nolist
            setlocal nospell
            setlocal noequalalways
            " vertical resize 25
        endf
        au FileType oil call s:oil_init()
    ]])

    local function oil_ssh_term()
      local fname = vim.fn.expand("%:p")
      if type(fname) == "table" then
        fname = fname[0]
      end
      local protocol, target, path = string.match(fname, "^(.+)://(.-)%/(.+)")
      if protocol ~= "oil-ssh" then
        path = fname
      end
      local basepath = path:match("(.*" .. "/" .. ")")
      if basepath == nil then
        basepath = vim.fn.expand("%:p:h")
      end
      local command
      if protocol == "oil-ssh" then
        command = "ssh " .. target .. " -t 'cd \\'" .. basepath .. "\\' && $SHELL'"
      else
        command = "cd \\'" .. basepath .. "\\' && $SHELL"
      end
      vim.cmd('call splitterm#open_width(18, "' .. command .. '")')
      vim.cmd("startinsert")
    end
    vim.api.nvim_create_user_command("OilSshTerm", oil_ssh_term, { bang = true, nargs = "?" })

    vim.api.nvim_set_hl(0, "OilFile", { fg = "#bbbbbb", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "OilDir", { fg = "#77aadd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "OilLink", { fg = "#77afaf", bg = "none", bold = true })

    local kopts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Leader>o", require("oil").open_float, kopts)
    -- vim.keymap.set("n", "<Leader>t", oil_ssh_term, kopts)
  end,
}
