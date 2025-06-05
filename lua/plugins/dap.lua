return {
  -- nvim-dap and its dependencies
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio", -- Required for nvim-dap
      "theHamsta/nvim-dap-virtual-text",
    },
    event = "VeryLazy",
    config = function()
      require "configs.dap" -- This will load our custom DAP config
    end,
  },
  -- nvim-dap-ui for the visual interface
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" }, -- Depends on nvim-dap
    config = function()
      -- We'll set up dapui here in custom.configs.dap for consistency
      -- Or you can setup simple setup here and add listeners in custom.configs.dap
      -- require("dapui").setup({}) -- Minimal setup, more detailed config below
    end,
  },
  -- mason-nvim-dap for managing debug adapters (like cpptools)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- Mason DAP setup is integrated into custom.configs.dap
    end,
  },
  -- Optional: For better type checking/autocomplete for dap-ui functions
  -- This needs lazydev.nvim to be configured
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "nvim-dap-ui",
        "nvim-dap",
        -- Add other libraries if needed, e.g., "neodev.nvim" if you use it for general nvim LSPs
      },
    },
  },
}
