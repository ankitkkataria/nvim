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
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
