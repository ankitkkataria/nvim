require "nvchad.mappings"

-- Basic remaps
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "K", "5gk")
vim.keymap.set("n", "J", "5gj")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("i", "<Home>", "<ESC>I")
vim.keymap.set("v", "J", "5gj")
vim.keymap.set("v", "K", "5gk")
vim.keymap.set("i", "<C-y>", "<C-w>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
vim.keymap.set({ "n", "v" }, "mb", "%")

vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>rW", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]], { desc = "Replace word under cursor (case-insensitive)" })
vim.keymap.set("n", "<leader>rl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor in current line" })
vim.keymap.set("n", "<leader>sw", [[:/\<<C-r><C-w>\><CR>]], { desc = "Search word under cursor (case-insensitive)" })

-- Hover
vim.api.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- Move the Lines in visual mode
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Copy/cut and paste to system clipboard
vim.keymap.set({ "n", "v" }, "y", [["+y]])
vim.keymap.set({ "n", "v" }, "Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "p", [["+p]])
vim.keymap.set({ "n", "v" }, "P", [["+P]])
vim.keymap.set({ "n", "v" }, "d", [["+d]])
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])

-- EasyMotion Settings
local hop = require "hop"
vim.keymap.set("", "s", function()
  hop.hint_char1()
end, { remap = true })
vim.keymap.set("", "<leader>l", function()
  hop.hint_lines_skip_whitespace()
end, { remap = true })

-- -- Visual mode key mapping
-- vim.keymap.set('v', '<C-d>', '<Plug>(VM-Find-Under)', { noremap = true, silent = true })
--
-- -- Normal mode key mapping
-- vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { noremap = true, silent = true })

-- Select text with Shift + Arrow keys in Insert mode
vim.api.nvim_set_keymap("i", "<S-Left>", "<C-O>v<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Right>", "<C-O>v<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Up>", "<C-O>v<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Down>", "<C-O>v<Down>", { noremap = true, silent = true })

-- Select text to the beginning and end of the line with Shift + Home/End in Insert mode
vim.api.nvim_set_keymap("i", "<S-Home>", "<C-O>v^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-End>", "<C-O>v<End>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Left>", "<C-O>v<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Right>", "<C-O>v<Right>", { noremap = true, silent = true })

-- Delete selected text with Backspace in Visual mode and go to Insert mode
vim.api.nvim_set_keymap("v", "<BS>", "dgi", { noremap = true, silent = true })

-- Indenting selected text and even after that we shall stay in visual mode so we can further indent
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Indent using Tab in visual mode
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Outdent using Shift-Tab in visual mode
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Quickly switch between current and previous opened tab
vim.api.nvim_set_keymap("n", "<leader><leader>", "<C-^>", { noremap = true, silent = true })

-- Keymaps for splits
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sc", ":close<CR>", { noremap = true, silent = true })

-- For joining two lines
vim.api.nvim_set_keymap("n", "<leader>j", "J", { noremap = true, silent = true })

-- nvimtree
-- vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

vim.keymap.set({ "n", "t" }, "<C-n>", function()
  -- Get the path of the current file
  local current_file_dir = vim.fn.expand "%:p:h"
  -- Check if a valid directory is found
  if current_file_dir and vim.fn.isdirectory(current_file_dir) == 1 then
    -- Change the current working directory to the file's directory
    vim.fn.chdir(current_file_dir)
  end
  -- Toggle the vertical terminal
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

vim.keymap.set("n", "<leader>tt", function()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config().virtual_text,
  }
end, { desc = "Toggle inline diagnostics" })
