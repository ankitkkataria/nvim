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
  -- {
  --   "stevearc/oil.nvim",
  --   opts = {},
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("oil").setup({
  --       default_file_explorer = true,
  --       delete_to_trash = true,
  --       skip_confirm_for_simple_edits = true,
  --       view_options = {
  --         show_hidden = true,
  --         natural_order = true,
  --         is_always_hidden = function(name, _)
  --           return name == ".." or name == ".git"
  --         end,
  --       },
  --       float = {
  --         padding = 2,
  --         max_width = 90,
  --         max_height = 0,
  --       },
  --       win_options = {
  --         wrap = true,
  --         winblend = 0,
  --       },
  --       keymaps = {
  --         ["<C-c>"] = false,
  --         ["q"] = "actions.close",
  --       },
  --     })
  --   end,
  -- },
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
