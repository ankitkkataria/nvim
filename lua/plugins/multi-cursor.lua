return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    lazy = false,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      
      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({"n", "x"}, "<leader>mC", function() mc.lineAddCursor(-1) end)
      set({"n", "x"}, "<leader>mc", function() mc.lineAddCursor(1) end)
      set({"n", "x"}, "<leader>mS", function() mc.lineSkipCursor(-1) end)
      set({"n", "x"}, "<leader>ms", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({"n", "x"}, "<F9>", function() mc.matchAddCursor(1) end)
      set({"n", "x"}, "ms", function() mc.matchSkipCursor(1) end)
      set({"n", "x"}, "mC", function() mc.matchAddCursor(-1) end)
      set({"n", "x"}, "mS", function() mc.matchSkipCursor(-1) end)

      -- Add and remove cursors with control + left click.
      set("n", "<C-leftmouse>", mc.handleMouse)
      set("n", "<C-leftdrag>", mc.handleMouseDrag)
      set("n", "<C-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({"n", "x"}, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)

        -- Select a different cursor as the main one.
        layerSet({"n", "x"}, "<left>", mc.prevCursor)
        layerSet({"n", "x"}, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({"n", "x"}, "md", mc.deleteCursor)

        -- Enable and clear cursors using escape.
       layerSet("n", "<leader>x", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)

       layerSet("n", "q", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn"})
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  },
}
