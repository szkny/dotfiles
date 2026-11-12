if vim.fn.has("termux") == 1 then
  vim.env.COPILOT_DISABLE_POLICY_WATCHER = "1"
end

require("base")
require("util")
require("keymap")
require("autocmd")
require("plugin_core")
