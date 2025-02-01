return {
  "nvimdev/dashboard-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- lazy = false,
  event = "VimEnter",
  config = function()
    local logo = ""
      .. "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗\n"
      .. "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║\n"
      .. "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║\n"
      .. "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║\n"
      .. "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║\n"
      .. "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\n"

    logo = string.rep("\n", 8) .. logo .. "\n\n"
    local header = vim.split(logo, "\n")
    require("dashboard").setup({
      theme = "hyper",
      disable_move = true, --  default is false disable move keymap for hyper
      shortcut_type = "number", --  shorcut type 'letter' or 'number'
      change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
      hide = {
        statusline = true,
        tabline = true,
        winbar = true,
      },
      -- preview = {
      --   command = "viu -x 15 -w 100 -t ~/dotfiles/nvim/logo/neovim-logo-2.png; read -q", -- preview command
      --   file_path = "", -- preview file path
      --   file_height = 20, -- preview file height
      --   file_width = 130, -- preview file width
      -- },
      -- preview = {
      --   command = [[
      --        FILE=$HOME/dotfiles/nvim/logo/nvim-ascii.txt;
      --        printf '%0.s\n' $(seq 1 $(($(tput lines) - $(wc -l < $FILE) - 2 )));
      --        cat $FILE;
      --        read -q
      --      ]], -- preview command
      --   file_path = "", -- preview file path
      --   file_height = 23, -- preview file height
      --   file_width = 40, -- preview file width
      -- },
      -- preview = {
      --   command = [[
      --           FILE=$HOME/dotfiles/nvim/logo/neovim-ascii-1.txt;
      --           printf '%0.s\n' $(seq 1 $(($(tput lines) - $(wc -l < $FILE) - 2 )));
      --           cat $FILE;
      --           read -q
      --         ]], -- preview command
      --   file_path = "", -- preview file path
      --   file_height = 20, -- preview file height
      --   file_width = 110, -- preview file width
      -- },
      -- preview = {
      --   command = [[
      --           FILE=$HOME/dotfiles/nvim/logo/neovim-ascii-2.txt;
      --           printf '%0.s\n' $(seq 1 $(($(tput lines) - $(wc -l < $FILE) - 2 )));
      --           cat $FILE;
      --           read -q
      --         ]], -- preview command
      --   file_path = "", -- preview file path
      --   file_height = 23, -- preview file height
      --   file_width = 110, -- preview file width
      -- },
      config = {
        header = header,
        week_header = {
          enable = false,
        },
        packages = { enable = true },
        shortcut = {
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Edit New",
            group = "@property",
            action = "enew!",
            key = "e",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "@property",
            action = "Files",
            key = "<C-p>",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Grep",
            group = "@property",
            action = "Rg",
            key = "<C-f>",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "FileTree",
            group = "@property",
            action = "enew! | Neotree show",
            key = "<C-n>",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Dotfiles",
            group = "@property",
            action = function()
              require("fzf-lua").fzf_exec(
                "rg --files -uuu -g !.git/ -g !node_modules/ -L -- ~/dotfiles",
                {
                  prompt = "Files> ",
                  previewer = "builtin",
                  actions = {
                    ["default"] = function(selected, opts)
                      require("fzf-lua").actions.file_edit(selected, opts)
                      vim.cmd("try | bnext | bdelete! | catch | endtry")
                    end,
                  },
                  fn_transform = function(x)
                    return require("fzf-lua").make_entry.file(x, {
                      file_icons = true,
                      color_icons = true,
                    })
                  end,
                }
              )
            end,
            key = ",",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Update",
            group = "@property",
            action = "Lazy update",
            key = "U",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Quit",
            group = "@property",
            action = "qall!",
            key = "q",
          },
        },
        project = {
          enable = true,
          limit = 4,
          icon = "  ",
          label = "Recent Projects:",
          action = "edit ",
        },
        mru = {
          limit = 5,
          icon = "  ",
          label = "Most Recent Files:",
          cwd_only = false,
        },
      },
    })
  end,
}
