return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterCyan",
          "RainbowDelimiterYellow",
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterGreen",
          "RainbowDelimiterBlue",
        },
      }
      -- For dark mode bracket colors
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#00ffff", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c792ea", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9500", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#ff6b9d", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ffd93d", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#0080ff", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#95e454", bold = true })

      -- For light mode bracket colors
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#007b83", bold = true }) 
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#6a1b9a", bold = true }) 
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#d35400", bold = true }) 
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#b71c1c", bold = true }) 
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#b7950b", bold = true }) 
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#0d47a1", bold = true })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#1b5e20", bold = true }) 

      -- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e06c75", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#e5c07b", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61afef", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#d19a66", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98c379", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c678dd", bold = true })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56b6c2", bold = true })
      --
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#ff6b9d", bold = true }) -- Hot pink
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#c9ff6b", bold = true }) -- Lime green
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#6bb9ff", bold = true }) -- Sky blue
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#00d4aa", bold = true }) -- Turquoise
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#b45bcf", bold = true }) -- Purple
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#0dcdcd", bold = true }) -- Electric cyan
    end,
  },
}
