local M = {}
M.setup = function()
  local cmp = require "cmp"
  local builtin = require "telescope.builtin"
  local telescope = require "telescope"
  dofile(vim.g.base46_cache .. "cmp")
  local cmp_ui = require("nvconfig").ui.cmp
  local cmp_style = cmp_ui.style
  local field_arrangement = {
    atom = { "kind", "abbr", "menu" },
    atom_colored = { "kind", "abbr", "menu" },
  }
  local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
    format = function(_, item)
      local icons = require "nvchad.icons.lspkind"
      local icon = (cmp_ui.icons and icons[item.kind]) or ""
      if cmp_style == "atom" or cmp_style == "atom_colored" then
        icon = " " .. icon .. " "
        item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
        item.kind = icon
      else
        icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
        item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
      end
      return item
    end,
  }
  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end
  local options = {
    completion = {
      completeopt = "menu,menuone",
    },
    window = {
      completion = {
        side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
        scrollbar = false,
      },
      documentation = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = formatting_style,
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    },
  }
  if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
    options.window.completion.border = border "CmpBorder"
  end
  cmp.setup(vim.tbl_deep_extend("force", options, require "nvchad.cmp"))

  -- `/` cmdline setup.
  -- cmp.setup.cmdline("/", {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = "buffer" },
  --   },
  -- })

  -- -- `:` cmdline setup.
  -- cmp.setup.cmdline(":", {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = "path" },
  --   }, {
  --     {
  --       name = "cmdline",
  --       option = {
  --         ignore_cmds = { "Man", "!" },
  --       },
  --     },
  --   }),
  -- })
  -- Set up cmdline mappings without Tab functionality
  local cmdline_mappings = cmp.mapping.preset.cmdline {
    -- Override with explicit Up/Down/Enter mappings
    ["<Up>"] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
        end
      end,
    },
    ["<Down>"] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true)
        end
      end,
    },
    ["<Tab>"] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item() -- Selects the next item
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
        end
      end,
    },
  }

  -- `/` cmdline setup.
  cmp.setup.cmdline("/", {
    mapping = cmdline_mappings,
    sources = {
      { name = "buffer" },
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local opts = { buffer = event.buf, remap = false }

      vim.keymap.set("n", "gr", function()
        -- Try to use Telescope if available, otherwise fall back to LSP references
        local ok, telescope = pcall(require, "telescope.builtin")
        if ok then
          telescope.lsp_references()
        else
          vim.lsp.buf.references()
        end
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))

      -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))

      vim.keymap.set("n", "ge", function()
        vim.diagnostic.open_float(0, { scope = "line" })
      end, { desc = "Line Diagnostics" })

      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))

      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
      end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))

      vim.keymap.set("n", "<F9>", function()
        vim.lsp.buf.hover()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))

      vim.keymap.set("n", "gh", function()
        vim.lsp.buf.hover()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))

      vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))

      vim.keymap.set("n", "<leader>vd", "<cmd>Telescope diagnostics<CR>", { desc = "Current Buffer Diagnostics" })

      vim.keymap.set("n", "<leader>vD", function()
        vim.diagnostic.setloclist()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))

      vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))

      vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))

      vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))

      vim.keymap.set("i", "<C-j>", function()
        vim.lsp.buf.signature_help()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))

      vim.keymap.set("i", "<F9>", function()
        vim.lsp.buf.signature_help()
      end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))

      vim.keymap.set(
        "n",
        "<leader>fs",
        builtin.lsp_document_symbols,
        vim.tbl_deep_extend("force", opts, { desc = "Find Symbols" })
      )
      
      vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })

      -- vim.keymap.set("n", "<leader>fts", "<cmd>Telescope treesitter<cr>", vim.tbl_deep_extend("force", opts, { desc = "Find Symbols" }))
    end,
  })
  -- cmp.setup.cmdline(':', {
  --   mapping = cmdline_mappings,
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     {
  --       name = 'cmdline',
  --       option = {
  --         ignore_cmds = { 'Man', '!' }
  --       }
  --     }
  --   })
  -- })
end
return M
