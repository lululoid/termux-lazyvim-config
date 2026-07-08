-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd.colorscheme "catppuccin"

-- Termux clipboard
vim.opt.clipboard = "unnamedplus"

local function split_lines(text)
  local lines = {}
  for line in string.gmatch(text .. "\n", "(.-)\r?\n") do
    table.insert(lines, line)
  end
  if #lines > 1 and lines[#lines] == "" then
    table.remove(lines)
  end
  return lines
end

vim.g.clipboard = {
  name = 'TermuxOSC52',
  copy = {
    ['+'] = function(lines, regtype)
      if vim.fn.executable('termux-clipboard-set') == 1 then
        vim.fn.system('termux-clipboard-set', table.concat(lines, '\n'))
      end
      require('vim.ui.clipboard.osc52').copy('+')(lines, regtype)
    end,
    ['*'] = function(lines, regtype)
      if vim.fn.executable('termux-clipboard-set') == 1 then
        vim.fn.system('termux-clipboard-set', table.concat(lines, '\n'))
      end
      require('vim.ui.clipboard.osc52').copy('*')(lines, regtype)
    end,
  },
  paste = {
    ['+'] = function()
      -- Phase 1: Try reading from Termux Clipboard
      if vim.fn.executable('termux-clipboard-get') == 1 then
        local output = vim.fn.system('termux-clipboard-get')
        if output and output ~= "" then
          return split_lines(output), 'v'
        end
      end
      -- Phase 2: Fall back to OSC 52
      local lines, regtype = require('vim.ui.clipboard.osc52').paste('+')()
      if lines and #lines > 0 and lines[1] ~= "" then
        return lines, regtype
      end
      -- Phase 3: Absolute safety guard to prevent E353 error
      return {''}, 'v'
    end,
    ['*'] = function()
      if vim.fn.executable('termux-clipboard-get') == 1 then
        local output = vim.fn.system('termux-clipboard-get')
        if output and output ~= "" then
          return split_lines(output), 'v'
        end
      end
      local lines, regtype = require('vim.ui.clipboard.osc52').paste('*')()
      if lines and #lines > 0 and lines[1] ~= "" then
        return lines, regtype
      end
      return {''}, 'v'
    end,
  },
  cache_enabled = 0,
}
