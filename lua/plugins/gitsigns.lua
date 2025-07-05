return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      local gitsigns = require "gitsigns"
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal { "]c", bang = true }
        else
          gitsigns.nav_hunk "next"
        end
      end)

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal { "[c", bang = true }
        else
          gitsigns.nav_hunk "prev"
        end
      end)
      map("n", "<leader>hs", gitsigns.stage_hunk)
      map("n", "<leader>hr", gitsigns.reset_hunk)
      map("n", "<leader>hp", gitsigns.preview_hunk)
      map("n", "<leader>hi", gitsigns.preview_hunk_inline)
      map("n", "<leader>hb", function()
        gitsigns.blame_line { full = true }
      end)
      map("n", "<leader>hd", gitsigns.diffthis)
      map("n", "<leader>hD", function()
        gitsigns.diffthis "~"
      end)
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
      map("n", "<leader>tw", gitsigns.toggle_word_diff)
      return require "nvchad.configs.gitsigns"
    end,
  },
}
