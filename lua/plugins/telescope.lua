return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-fzf-native.nvim",
      "AckslD/nvim-neoclip.lua",
      "debugloop/telescope-undo.nvim",
      "aaronhallaert/advanced-git-search.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "jvgrootveld/telescope-zoxide",
    },
    cmd = "Telescope",
    opts = function()
      local telescope_config = require "nvchad.configs.telescope"

      -- Add basic fzf configuration
      telescope_config.extensions = telescope_config.extensions or {}
      telescope_config.extensions.fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }

      return telescope_config
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "fzf"
      require("telescope").load_extension "neoclip"
      require("telescope").load_extension "undo"
      require("telescope").load_extension "advanced_git_search"
      require("telescope").load_extension "live_grep_args"
      require("telescope").load_extension "zoxide"
      vim.g.zoxide_use_select = true
    end,
  },
}
