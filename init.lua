-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd.colorscheme "catppuccin"
vim.o.wrap = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.wrap = true
vim.o.breakindent = true

-- Termux clipboard
return {
  g = {
    clipboard = {
      name = "termux-clipboard",
      copy = {
        ["+"] = "termux-clipboard-set",
        ["*"] = "termux-clipboard-set",
      },
      paste = {
        ["+"] = "termux-clipboard-get",
        ["*"] = "termux-clipboard-get",
      },
      cache_enabled = 0,
    },
  },
}
