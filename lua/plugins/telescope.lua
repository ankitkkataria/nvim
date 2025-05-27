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

      -- Add the multi-select function
      local select_one_or_multi = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require("telescope.actions").close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
          end
        else
          require("telescope.actions").select_default(prompt_bufnr)
        end
      end

      -- Override the default Enter behavior
      telescope_config.defaults = telescope_config.defaults or {}
      telescope_config.defaults.mappings = telescope_config.defaults.mappings or {}
      telescope_config.defaults.mappings.i = telescope_config.defaults.mappings.i or {}
      telescope_config.defaults.mappings.i["<CR>"] = select_one_or_multi

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
