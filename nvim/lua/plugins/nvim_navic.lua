return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    icons = {
      File = " ",
      Module = " ",
      Namespace = " ",
      Package = " ",
      Class = " ",
      Method = " ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = " ",
      Variable = " ",
      Constant = " ",
      String = " ",
      Number = " ",
      Boolean = " ",
      Array = " ",
      Object = " ",
      Key = " ",
      Null = " ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
    lsp = {
      auto_attach = true,
      preference = nil,
    },
    highlight = true,
    separator = " 〉",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = true,
  },
  config = function(_, opts)
    require("nvim-navic").setup(opts)
    vim.api.nvim_set_hl(0, "NavicIconsFile", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsModule", { bold = false, bg = "none", fg = "#bbbb55" })
    vim.api.nvim_set_hl(0, "NavicIconsNamespace", { bold = false, bg = "none", fg = "#bbbb55" })
    vim.api.nvim_set_hl(0, "NavicIconsPackage", { bold = false, bg = "none", fg = "#c08855" })
    vim.api.nvim_set_hl(0, "NavicIconsClass", { bold = false, bg = "none", fg = "#c08855" })
    vim.api.nvim_set_hl(0, "NavicIconsMethod", { bold = false, bg = "none", fg = "#bb9999" })
    vim.api.nvim_set_hl(0, "NavicIconsProperty", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsField", { bold = false, bg = "none", fg = "#5577bb" })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor", { bold = false, bg = "none", fg = "#bb9999" })
    vim.api.nvim_set_hl(0, "NavicIconsEnum", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsInterface", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsFunction", { bold = false, bg = "none", fg = "#bb9999" })
    vim.api.nvim_set_hl(0, "NavicIconsVariable", { bold = false, bg = "none", fg = "#5577bb" })
    vim.api.nvim_set_hl(0, "NavicIconsConstant", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsString", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsNumber", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsBoolean", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsArray", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsObject", { bold = false, bg = "none", fg = "#bbbb55" })
    vim.api.nvim_set_hl(0, "NavicIconsKey", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsNull", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsStruct", { bold = false, bg = "none", fg = "#c08855" })
    vim.api.nvim_set_hl(0, "NavicIconsEvent", { bold = false, bg = "none", fg = "#bbbb55" })
    vim.api.nvim_set_hl(0, "NavicIconsOperator", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { bold = false, bg = "none", fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "NavicText", { bold = false, bg = "none", fg = "#888888" })
    vim.api.nvim_set_hl(0, "NavicSeparator", { bold = false, bg = "none", fg = "#aaaaaa" })
  end,
}
