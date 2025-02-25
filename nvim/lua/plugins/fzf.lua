return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "sindrets/diffview.nvim",
  },
  event = "VeryLazy",
  commit = "b442569",
  cmd = {
    "FzfLua",
  },
  keys = {
    { "<C-b>", "<CMD>FzfLua buffers<CR>", mode = "n" },
    { "<Leader>[", function()
      require("fzf-lua").lsp_references({ ignore_current_line = true, includeDeclaration = false })
    end, mode = "n" },
    { "<Leader>s", "<CMD>FzfLua lsp_document_symbols<CR>", mode = "n" },
    { "<Leader>/", "<CMD>FzfLua lines<CR>", mode = "n" },
    { "<Leader>b/", "<CMD>FzfLua blines<CR>", mode = "n" },
    { "<Leader>m", "<CMD>FzfLua marks<CR>", mode = "n" },
  },
  opts = {
    "default",
    -- "fzf-vim",
    -- "telescope",
    file_icon_padding = " ",
    winopts = {
      height = 0.90,
      width = 0.85,
      row = 0.35,
      col = 0.50,
      border = "rounded",
      fullscreen = false,
      preview = {
        default = "builtin",
        border = "border",
        wrap = "nowrap",
        hidden = "nohidden",
        vertical = "down:45%",
        horizontal = "right:60%",
        layout = "flex",
        flip_columns = 120,
        title = true,
        title_pos = "center",
        scrollbar = "float",
        scrolloff = "-2",
        scrollchars = { "█", "" },
        delay = 0,
        winopts = {
          number = true,
          relativenumber = false,
          cursorline = true,
          cursorlineopt = "both",
          cursorcolumn = false,
          signcolumn = "no",
          list = false,
          foldenable = false,
          foldmethod = "manual",
        },
      },
      on_create = function()
        -- vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
        -- vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
      end,
    },
    previewers = {
      builtin = {
        syntax = true,
        syntax_limit_l = 0,
        syntax_limit_b = 1024 * 1024 * 0.5,
        limit_b = 1024 * 1024 * 0.5,
        -- limit_b = 1024 * 1024 * 10,
        treesitter = { enable = true, disable = {} },
        toggle_behavior = "default",
      },
    },
    keymap = {
      builtin = {
        ["<C-_>"] = "toggle-preview",
        ["<C-j>"] = "preview-page-down",
        ["<C-k>"] = "preview-page-up",
      },
    },
    git = {
      bcommits = {
        prompt        = "Git Log❯ ",
        cmd           = "git log --color --date=format:'%Y-%m-%d %H:%M' --pretty=format:\"%C(yellow)%h %C(blue)(%cd)%Creset %s %C(blue)<%an>\" -- {file}",
        preview       = "git show --color {1} -- {file}",
        actions = {
          ["default"] = function(selected)
            local commit_hash = selected[1]:match("^(%x+)")
            if commit_hash then
              local file_path = vim.fn.expand("%")
              vim.cmd("DiffviewOpen " .. commit_hash .. " -- " .. file_path)
            else
              print("Invalid commit hash")
            end
          end,
        },
      },
    }
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)

    local NormalHl = vim.api.nvim_get_hl(0, { name = "Normal" })
    vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = NormalHl.fg, bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { link = "Cursorline" })
    vim.api.nvim_set_hl(0, "FzfLuaPreview", { fg = "none", bg = "none" })

    -- keymaps
    local get_visual_selection = function()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg("v")
      vim.fn.setreg("v", {})
      text = string.gsub(tostring(text), "\n", "")
      if #text > 0 then
        return text
      else
        return ""
      end
    end

    local CustomPreviewer = require("fzf-lua.previewer.builtin").buffer_or_file:extend()
    function CustomPreviewer:new(o, previewer_opts, fzf_win)
      CustomPreviewer.super.new(self, o, previewer_opts, fzf_win)
      setmetatable(self, CustomPreviewer)
      return self
    end
    function CustomPreviewer:populate_preview_buf(entry_str)
      entry_str = entry_str:sub(8, -1):gsub("^[  ]", "")
      -- entry_str = entry_str:match("([%wぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠!-/:-@[-`{-~]+)$")
      local tmpbuf = self:get_tmp_buffer()
      local preview_winid = self.win.preview_winid
      local ext = vim.fn.fnamemodify(entry_str, ':e')
      if vim.tbl_contains({ "png", "jpg", "jpeg" }, string.lower(ext)) then
        local win_width = vim.api.nvim_win_get_width(preview_winid)
        local command = ("viu -w %d %s; sleep 1000"):format(win_width - 4, entry_str)
        vim.api.nvim_buf_call(tmpbuf, function() vim.fn.termopen(command) end)
        self:set_preview_buf(tmpbuf)
      else
        local entry = self:parse_entry(entry_str)
        require("fzf-lua.utils").read_file_async(entry_str, vim.schedule_wrap(function(data)
          local lines = vim.split(data, "[\r]?\n")
          if data:sub(#data, #data) == "\n" or data:sub(#data - 1, #data) == "\r\n" then
            table.remove(lines)
          end
          vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lines)
          self:set_preview_buf(tmpbuf)
          self:preview_buf_post(entry)
          self.win:update_scrollbar()
        end))
      end
      self.win:update_scrollbar()
    end

    local rg_cmd_file = "rg --files -uuu -g '!**/{.git,node_modules,.venv,.mypy_cache,__pycache__}/*' -L"
    local rg_cmd_grep = "rg --line-number --ignore-case --color=always -- "

    local fzf_exec_opts_file = {
      prompt = "Files❯ ",
      previewer = CustomPreviewer,
      actions = {
        ["default"] = require("fzf-lua").actions.file_edit,
        ["ctrl-s"] = require("fzf-lua").actions.file_split,
        ["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
        ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
        ["ctrl-q"] = require("fzf-lua").actions.file_sel_to_qf,
      },
      fn_transform = function(x)
        return require("fzf-lua").make_entry.file(x, {
          file_icons = true,
          color_icons = true,
        })
      end,
      fzf_opts = {
        ["--ansi"] = true,
        ["--header"] = "ctrl-s:split, ctrl-v:vsplit, ctrl-t:tabedit, ctrl-q:qf",
      }
    }
    local fzf_exec_opts_grep = {
      prompt = "Rg❯ ",
      previewer = "builtin",
      actions = {
        ["default"] = require("fzf-lua").actions.file_edit,
        ["ctrl-s"] = require("fzf-lua").actions.file_split,
        ["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
        ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
        ["ctrl-q"] = require("fzf-lua").actions.file_sel_to_qf,
      },
      fn_transform = function(x)
        x = string.gsub(x, "[ ]+", " ")
        return require("fzf-lua").make_entry.file(x, {
          file_icons = true,
          color_icons = true,
        })
      end,
      fzf_opts = {
        ["--ansi"] = true,
        ["--header"] = "ctrl-s:split, ctrl-v:vsplit, ctrl-t:tabedit, ctrl-q:qf",
      }
    }

    vim.keymap.set({ "n", "v" }, "<C-p>", function()
      require("fzf-lua").fzf_exec(rg_cmd_file, fzf_exec_opts_file)
    end, { silent = true })

    vim.keymap.set("n", "<C-f>", function()
      require("fzf-lua").fzf_exec(rg_cmd_grep .. ".", fzf_exec_opts_grep)
    end, { silent = true })

    vim.keymap.set("v", "<C-f>", function()
      local text = get_visual_selection()
      require("fzf-lua").fzf_exec(rg_cmd_grep .. text, fzf_exec_opts_grep)
    end, { silent = true })

    vim.keymap.set("v", "<Leader>/", function()
      local text = get_visual_selection()
      require("fzf-lua").lines()
      vim.api.nvim_feedkeys(text, "t", true)
    end, { silent = true })

    -- commands
    vim.api.nvim_create_user_command("Files", function() require("fzf-lua").fzf_exec(rg_cmd_file, fzf_exec_opts_file) end, {})
    vim.api.nvim_create_user_command("Rg",    function() require("fzf-lua").fzf_exec(rg_cmd_grep .. ".", fzf_exec_opts_grep) end, {})
    vim.api.nvim_create_user_command("Icons", function()
      local icons = require("data.icons").get_icons()
      require("fzf-lua").fzf_exec(function(fzf_cb)
        coroutine.wrap(function()
          local co = coroutine.running()
          for k, v in pairs(icons) do
            vim.schedule(function()
              fzf_cb(v .. " : " .. k, function()
                coroutine.resume(co)
              end)
            end)
            coroutine.yield()
          end
          fzf_cb()
        end)()
      end, {
        prompt = "Icons❯ ",
        winopts = {
          width = 0.5,
          height = 0.5,
        },
        previewer = nil,
        actions = {
          ["default"] = function(item)
            if #item > 0 then
              local icon = item[1]:sub(0, 4)
              print("yank : " .. icon)
              vim.fn.setreg("", icon)
            end
          end,
        },
      })
    end, {})

    -- Zg
    local ZgPreviewer = require("fzf-lua.previewer.builtin").base:extend()
    function ZgPreviewer:populate_preview_buf(entry_str)
      local command = ("eza -T --color=always --icons '%s'; sleep 1000"):format(entry_str)
      local tmpbuf = self:get_tmp_buffer()
      vim.api.nvim_buf_set_option(tmpbuf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(tmpbuf, "bufhidden", "wipe")
      vim.api.nvim_buf_call(tmpbuf, function() vim.fn.termopen(command) end)
      self:set_preview_buf(tmpbuf)
      self.win:update_scrollbar()
    end

    function ZgPreviewer:new(o, previewer_opts, fzf_win)
      ZgPreviewer.super.new(self, o, previewer_opts, fzf_win)
      setmetatable(self, ZgPreviewer)
      return self
    end

    function ZgPreviewer:gen_winopts()
      local new_winopts = {
        wrap    = false,
        number  = false,
      }
      return vim.tbl_extend("force", self.winopts, new_winopts)
    end

    function ZgPreviewer:scroll(direction)
      local utils = require("fzf-lua.utils")
      local preview_winid = self.win.preview_winid
      if preview_winid < 0 or not direction then return end
      if not vim.api.nvim_win_is_valid(preview_winid) then return end
      if direction == "reset" then
        pcall(vim.api.nvim_win_call, preview_winid, function()
          vim.api.nvim_win_set_cursor(0, { 1, 0 })
          if self.orig_pos then
            vim.api.nvim_win_set_cursor(0, self.orig_pos)
          end
          utils.zz()
        end)
      else
        local input = direction == "page-down" and "<C-d>" or "<C-u>"
        vim.cmd("stopinsert")
        utils.feed_keys_termcodes(([[:noa lua vim.api.nvim_win_call(%d, function() vim.cmd("norm! <C-v>%s") vim.cmd("startinsert") end)<CR>]]):format(tonumber(preview_winid), input))
      end
      self.win:update_scrollbar()
    end

    local Zg = function()
      require("fzf-lua").fzf_exec("zoxide query --list", {
        prompt = "Zg❯ ",
        previewer = ZgPreviewer,
        actions = {
          ["default"] = function(selected)
            if selected and #selected > 0 then
              local dir = selected[1]
              vim.cmd("cd " .. vim.fn.fnameescape(dir))
              vim.notify("Changed directory to: " .. dir, vim.log.levels.INFO)
            end
          end,
        },
      })
    end
    vim.api.nvim_create_user_command("Zg", Zg, {})
    vim.keymap.set("n", "<C-g>", Zg, { silent = true })

    -- Git log
    local GitShowPreviewer = require("fzf-lua.previewer.builtin").base:extend()
    function GitShowPreviewer:new(o, previewer_opts, fzf_win)
      GitShowPreviewer.super.new(self, o, previewer_opts, fzf_win)
      setmetatable(self, GitShowPreviewer)
      return self
    end

    function GitShowPreviewer:gen_winopts()
      local new_winopts = {
        wrap    = false,
        number  = false,
      }
      return vim.tbl_extend("force", self.winopts, new_winopts)
    end

    function GitShowPreviewer:populate_preview_buf(entry_str)
      local commit_hash = entry_str:match("(%x+)%s%(")
      local command = "git show " .. commit_hash
        .. "| delta --paging=never "
        .. "| bat --color=always --paging=never --style=plain"
        .. "; sleep 1000"
      local tmpbuf = self:get_tmp_buffer()
      vim.api.nvim_buf_set_option(tmpbuf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(tmpbuf, "bufhidden", "wipe")
      vim.api.nvim_buf_call(tmpbuf, function() vim.fn.termopen(command) end)
      self:set_preview_buf(tmpbuf)
      self.win:update_scrollbar()
    end

    function GitShowPreviewer:scroll(direction)
      local utils = require("fzf-lua.utils")
      local preview_winid = self.win.preview_winid
      if preview_winid < 0 or not direction then return end
      if not vim.api.nvim_win_is_valid(preview_winid) then return end
      if direction == "reset" then
        pcall(vim.api.nvim_win_call, preview_winid, function()
          vim.api.nvim_win_set_cursor(0, { 1, 0 })
          if self.orig_pos then
            vim.api.nvim_win_set_cursor(0, self.orig_pos)
          end
          utils.zz()
        end)
      else
        local input = direction == "page-down" and "<C-d>" or "<C-u>"
        vim.cmd("stopinsert")
        utils.feed_keys_termcodes(([[:noa lua vim.api.nvim_win_call(%d, function() vim.cmd("norm! <C-v>%s") vim.cmd("startinsert") end)<CR>]]):format(tonumber(preview_winid), input))
      end
      self.win:update_scrollbar()
    end

    local GitLog =  function()
      require("fzf-lua").fzf_exec(
        "git log --color --date=format:'%Y-%m-%d %H:%M' --pretty=format:\"%C(yellow)%h %C(blue)(%cd)%Creset %s %C(blue)<%an>\" -- " .. vim.fn.expand("%"),
        {
          prompt = "Git Log❯ ",
          previewer = GitShowPreviewer,
          actions = {
            ["default"] = function(selected)
              local commit_hash = selected[1]:match("(%x+)%s%(")
              if commit_hash then
                local file_path = vim.fn.expand("%")
                vim.cmd("DiffviewOpen " .. commit_hash .. " -- " .. file_path)
              else
                print("Invalid commit hash")
              end
            end,
          },
          fn_transform = function(entry_str)
            return require("fzf-lua").make_entry.file(entry_str, {
              file_icons = true,
              color_icons = true,
            })
          end,
        }
      )
    end
    vim.api.nvim_create_user_command("GitLog", GitLog, {})
    vim.api.nvim_create_user_command("GitFileHistory", function() vim.cmd("DiffviewFileHistory") end, {})
    vim.keymap.set("n", "<Leader>gl", GitLog, { silent = true })
  end,
}
