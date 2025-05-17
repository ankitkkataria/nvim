vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Highlight yanked text for a short time
  vim.api.nvim_exec([[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=200})
    augroup end
  ]], false)

vim.opt.smartindent = true
vim.o.wrap = false

-- ~/.config/nvim/lua/custom/init.lua

vim.diagnostic.disable()

vim.api.nvim_set_hl(0, 'Cursor', { fg = '#000000', bg = '#44ffff' }) -- Black text, white background
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })
