-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "material-deep-ocean",
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  cmp = {
    icons_left = false, -- only for non-atom styles!
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 60,
    -- for tailwind, css lsp etc
    format_colors = { lsp = true, icon = "󱓻" },
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  statusline = {
    enabled = true,
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
    bufwidth = 21,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    -- "     Powered By Neovim    ",
  },

  buttons = {
    { txt = "  Find Files          ", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files        ", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word           ", keys = "fw", cmd = "Telescope live_grep" },
    {
      txt = "  File Explorer       ",
      keys = "m",
      cmd = ":lua require('mini.files').open(vim.loop.cwd(), false)<CR>",
    },
    {
      txt = "  Sessions            ",
      keys = "sa",
      cmd = ":lua require('persistence').select()",
    },
    -- { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    -- { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    --
    -- {
    --   txt = function()
    --     local stats = require("lazy").stats()
    --     local ms = math.floor(stats.startuptime) .. " ms"
    --     return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
    --   end,
    --   hl = "NvDashFooter",
    --   no_gap = true,
    -- },
    --
    -- { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

M.term = {
  base46_colors = true,
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.35, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

return M
