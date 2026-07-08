-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd.colorscheme "catppuccin"

-- Termux clipboard
local osc52_copy_plus = require('vim.ui.clipboard.osc52').copy('+')
local osc52_copy_star = require('vim.ui.clipboard.osc52').copy('*')

vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "combined-osc52-termux",
  copy = {
    ["+"] = function(lines, regtype)
      osc52_copy_plus(lines, regtype)
      vim.fn.system("termux-clipboard-set", table.concat(lines, "\n"))
    end,
    ["*"] = function(lines, regtype)
      osc52_copy_star(lines, regtype)
      vim.fn.system("termux-clipboard-set", table.concat(lines, "\n"))
    end,
  },
  paste = {
    -- OSC 52 paste is typically blocked, so fall back completely to Termux
    ["+"] = { "termux-clipboard-get" },
    ["*"] = { "termux-clipboard-get" },
  },
  cache_enabled = 0,
}
