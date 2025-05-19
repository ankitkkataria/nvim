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
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = {
        enabled = false, -- disable current context highlight
        char = "│",
        highlight = "IblScopeChar",
      },
    },

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
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
  -- {
  --   "rmagatti/auto-session",
  --   lazy = false,
  --   keys = {
  --     -- Will use Telescope if installed or a vim.ui.select picker otherwise
  --     { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
  --     { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
  --     { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  --   },
  --
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     -- ⚠️ This will only work if Telescope.nvim is installed
  --     -- The following are already the default values, no need to provide them if these are already the settings you want.
  --     session_lens = {
  --       -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
  --       load_on_setup = true,
  --       previewer = false,
  --       mappings = {
  --         -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
  --         delete_session = { "i", "<C-D>" },
  --         alternate_session = { "i", "<C-S>" },
  --         copy_session = { "i", "<C-Y>" },
  --       },
  --       -- Can also set some Telescope picker options
  --       -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
  --       theme_conf = {
  --         border = true,
  --         -- layout_config = {
  --         --   width = 0.8, -- Can set width and height as percent of window
  --         --   height = 0.5,
  --         -- },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   config = function()
  --     require("toggleterm").setup {
  --       size = 50,
  --       open_mapping = [[<c-n>]],
  --       shade_filetypes = {},
  --       shade_terminals = true,
  --       shading_factor = 2,
  --       start_in_insert = true,
  --       persist_size = false,
  --       direction = "vertical",
  --       close_on_exit = true,
  --       shell = vim.o.shell,
  --       float_opts = {
  --         border = "curved",
  --         winblend = 0,
  --         highlights = {
  --           border = "Normal",
  --           background = "Normal",
  --         },
  --       },
  --     }
  -- },
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
