-- https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/nvim-treesitter-context.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/nvim-treesitter-context.lua
--
-- If on a markdown file, and you're inside a level 4 heading, this plugin shows
-- you the level 2 and 3 heading that you're under at the top of the screen
-- Really useful to know where you're at
--
-- This plugin used to be enabled by default in lazyvim, but it was moved to
-- extras lamw25wmal
--
-- I just copied Folke's config here
-- https://www.lazyvim.org/extras/ui/treesitter-context#nvim-treesitter-context

return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  opts = { mode = "cursor", max_lines = 1 },
  keys = {
    {
      "<leader>ts",
      function()
        local tsc = require "treesitter-context"
        tsc.toggle()
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}
