return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "romgrk/barbar.nvim",
  },
  cmd = { "NvimTreeToggle" },
  keys = {
    { "<C-n>", "<CMD>NvimTreeToggle<CR>", mode = "n" },
  },
  opts = {
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      width = {
        min = 25,
        max = 40,
      },
      signcolumn = "yes",
      preserve_window_proportions = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_modified = "name",
      full_name = false,
      root_folder_label = false,
      indent_width = 2,
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        git_placement = "before",
        modified_placement = "after",
        padding = " ",
        symlink_arrow = " → ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
        },
        glyphs = {
          git = {
            unstaged = "M",
            staged = "✓",
            unmerged = "✗",
            renamed = "R",
            untracked = "U",
            deleted = "D",
            ignored = "◌",
          },
        },
      },
      special_files = { "Makefile", "README.md" },
    },
    update_focused_file = {
      enable = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
        -- error = "",
        -- warning = "",
        -- info = "",
        -- hint = "",
      },
    },
    filters = {
      dotfiles = true,
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    trash = {
      cmd = "rip",
      require_confirm = true,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local opts = function(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
      vim.keymap.set("n", "I", api.tree.toggle_hidden_filter, opts("Toggle Ignore"))
      vim.keymap.set("n", "<BS>", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
      vim.keymap.set("n", "<C-h>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "<C-l>", api.tree.change_root_to_node, opts("Cd"))
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      vim.keymap.set("n", "<C-f>", api.live_filter.start, opts("Filter"))
      vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "O", api.tree.expand_all, opts("Expand All"))
      vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
    end,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.api.nvim_set_var("loaded_netrw", 1)
    vim.api.nvim_set_var("loaded_netrwPlugin", 1)
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#555555", bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#bbbbbb", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#77aadd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#77aadd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#77aadd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "#dfbf66", bg = "none", bold = true, underline = true })
    vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = "#77afaf", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName", { fg = "#77afaf", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#bfbf66", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#ddaa55", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#44cc44", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#44cc44", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeModifiedIcon", { fg = "#ffaa00", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeModifiedFileHL", { fg = "#ffaa00", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeModifiedFolderHL", { fg = "#ffaa00", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsError", { fg = "#ee3333", bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsWarning", { fg = "#edd000", bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsInformation", { fg = "#ffffff", bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsHint", { fg = "#5588dd", bg = "none" })
  end,
}
