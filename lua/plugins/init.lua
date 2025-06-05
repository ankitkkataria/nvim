return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false, -- This disables nvim-tree
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "clangd",
        "jdtls",
        "cpptools"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "java",
        "cpp",
      },
    },
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "pocco81/auto-save.nvim",
  },
  -- Better text objects.
  -- test new blink
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function()
      local miniai = require "mini.ai"

      return {
        n_lines = 300,
        custom_textobjects = {
          f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        },
        -- Keep error feedback enabled so it doesn't interfere with other plugins
        silent = false,
        -- Remove search_method to use default which might fix conflicts
        -- Remove the custom mappings so it does not override default text objects.
        mappings = {},
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = {
        char = "│",
        highlight = "IblScopeChar",
        -- Add these lines to disable the scope's background highlighting
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      -- Add this hook to customize just the line colors
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Make the indent lines more visible (black in this example)
        vim.api.nvim_set_hl(0, "IblChar", { fg = "#2F4F4F" })
        -- Make scope lines stand out (green) without background highlight
        vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#a6a2a2" })
        -- Ensure no background for scope
        vim.api.nvim_set_hl(0, "IblScope", { bg = "NONE" })
      end)
      require("ibl").setup(opts)
      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
  { "hrsh7th/cmp-cmdline", event = "BufReadPre" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- We call setup from our configs.cmp module after the plugin is loaded
      require("configs.cmp").setup()
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = true, -- uses default config
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   cmd = "Telescope",
  --   opts = function()
  --     return require "nvchad.configs.telescope"
  --   end,
  -- },
  {
    -- detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  { "nvim-java/nvim-java" },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  --  Powerful Git integration for Vim
  -- {
  --   "tpope/vim-fugitive",
  -- },
  -- {
  --   -- GitHub integration for vim-fugitive
  --   "tpope/vim-rhubarb",
  -- },
}
