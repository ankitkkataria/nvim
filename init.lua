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

-- Define custom yank highlight group
vim.api.nvim_set_hl(0, "YankHighlight", { fg = "#000000", bg = "#FFD1DC", bold = true })

-- Change search highlight color
vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = "#FFD1DC", bold = true })

-- Change search highlight color when the cursor is on the selection 
vim.api.nvim_set_hl(0, "CurSearch", { fg = "#000000", bg = "#FF6F61", bold = true })

-- Highlight yanked text using custom group
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="YankHighlight", timeout=200})
  augroup end
]], false)


-- Highlight yanked text for a short time
  vim.api.nvim_exec([[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=200})
    augroup end
  ]], false)

vim.opt.smartindent = true
vim.o.wrap = false

vim.diagnostic.disable()


vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"zz'  -- Added 'zz' to center the cursor
    end
  end,
})

-- Disable automatic comment continuation
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "FileType"}, {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#ffffff", bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#ffffff", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#FF007F", bg = "NONE", bold = true }) 

-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333344" })

-- Just some colors
-- vim.api.nvim_set_hl(0, "MyPastelPink", { fg = "#FFD1DC", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelBlue", { fg = "#AEC6CF", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelGreen", { fg = "#77DD77", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelPurple", { fg = "#CBAACB", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelYellow", { fg = "#FFF5BA", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelOrange", { fg = "#FFB347", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelTeal", { fg = "#99E1D9", bg = "NONE", bold = false })
-- vim.api.nvim_set_hl(0, "MyPastelCoral", { fg = "#FF6F61", bg = "NONE", bold = false })

