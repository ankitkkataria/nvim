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
vim.keymap.set("i", "<C-h>", "<C-w>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
vim.keymap.set({ "n", "v" }, "mb", "%")

vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Switch to last buffer" })
vim.keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>rW",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]],
  { desc = "Replace word under cursor (case-insensitive)" }
)
vim.keymap.set(
  "n",
  "<leader>rl",
  [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor in current line" }
)
vim.keymap.set("n", "<leader>sw", [[:/\<<C-r><C-w>\><CR>]], { desc = "Search word under cursor (case-insensitive)" })

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

-- Keymaps for splits
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sc", ":close<CR>", { noremap = true, silent = true })

-- Movement between splits
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
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

-- new terminals
-- vim.keymap.set("n", "<leader>ht", function()
--   require("nvchad.term").new { pos = "sp" }
-- end, { desc = "terminal new horizontal term" })
--
-- vim.keymap.set("n", "<leader>vt", function()
--   require("nvchad.term").new { pos = "vsp" }
-- end, { desc = "terminal new vertical term" })

-- toggleable
vim.keymap.set({ "n", "t" }, "<C-n>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

vim.keymap.set({ "n", "t" }, "<C-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

vim.keymap.set("n", "<leader>n", function()
  -- Use absolute path instead of relative path
  local default_path = vim.fn.expand "%:p:h" .. "/" -- :p gives the full path

  local path = vim.fn.input("New file: ", default_path, "file")
  if path == "" then
    return
  end

  -- Check if the path ends with '/' indicating a directory
  local is_directory = path:sub(-1) == "/"

  -- Handle both file and directory creation
  if is_directory then
    -- Create directory
    local success = vim.fn.mkdir(path, "p")
    if success == 1 then
      vim.notify("Created directory: " .. path, vim.log.levels.INFO)
    else
      vim.notify("Failed to create directory: " .. path, vim.log.levels.ERROR)
    end
  else
    -- Ensure parent directories exist
    local dir = vim.fn.fnamemodify(path, ":h")
    if dir ~= "" and dir ~= "." and vim.fn.isdirectory(dir) == 0 then
      local success = vim.fn.mkdir(dir, "p")
      if success ~= 1 then
        vim.notify("Failed to create parent directory: " .. dir, vim.log.levels.ERROR)
        return
      end
    end

    -- Create/save the file
    local file = io.open(path, "a")
    if file then
      file:close()
      -- Open the file in a new buffer and focus on it
      vim.cmd("e " .. vim.fn.fnameescape(path))
    else
      vim.notify("Failed to create file: " .. path, vim.log.levels.ERROR)
    end
  end
end, opts)

-- Map leader rn to rename current file
vim.keymap.set("n", "<leader>rn", function()
  -- Get current file path
  local current_file = vim.fn.expand "%:p"

  -- Check if we're in a buffer with a file
  if current_file == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.ERROR)
    return
  end

  -- Get directory of current file
  local current_dir = vim.fn.expand "%:p:h" .. "/"

  -- Get current filename
  local current_filename = vim.fn.expand "%:t"

  -- Prompt for new path with current file path as default
  local new_path = vim.fn.input("Rename to: ", current_file, "file")

  -- If user cancels, return
  if new_path == "" or new_path == current_file then
    return
  end

  -- Ensure parent directories exist for the new path
  local new_dir = vim.fn.fnamemodify(new_path, ":h")
  if new_dir ~= "" and new_dir ~= "." and vim.fn.isdirectory(new_dir) == 0 then
    local dir_success = vim.fn.mkdir(new_dir, "p")
    if dir_success ~= 1 then
      vim.notify("Failed to create parent directory: " .. new_dir, vim.log.levels.ERROR)
      return
    end
  end

  -- Save current buffer if it has changes
  if vim.bo.modified then
    vim.cmd "write"
  end

  -- Rename the file
  local rename_success = os.rename(current_file, new_path)

  if rename_success then
    -- Close the current buffer
    vim.cmd("bdelete " .. vim.fn.fnameescape(current_file))

    -- Open the new file
    vim.cmd("edit " .. vim.fn.fnameescape(new_path))

    vim.notify("Renamed " .. current_filename .. " to " .. vim.fn.fnamemodify(new_path, ":t"), vim.log.levels.INFO)
  else
    vim.notify("Failed to rename file", vim.log.levels.ERROR)
  end
end, { desc = "Rename current file" })

-- Split line with X
-- vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { silent = true })

-- Session related mappings
vim.keymap.set("n", "<leader>ss", function()
  require("persistence").load()
end, { desc = "Restore session for current directory" })

vim.keymap.set("n", "<leader>sa", function()
  require("persistence").select()
end, { desc = "Select and restore session" })

vim.keymap.set("n", "<leader>sl", function()
  require("persistence").load { last = true }
end, { desc = "Restore last session" })

vim.keymap.set("n", "<leader>sd", function()
  require("persistence").stop()
end, { desc = "Stop session saving" })

-- Marks related mappings
vim.keymap.set("n", "<leader>rm", function()
  local line = vim.fn.line "."
  -- Get all marks in the current buffer
  local marks = vim.fn.getmarklist(vim.fn.bufnr())

  -- Filter to marks on the current line
  for _, mark in ipairs(marks) do
    if mark.pos[2] == line then
      -- Delete the mark (mark.mark contains the mark name with a leading ')
      local mark_name = string.sub(mark.mark, 2)
      vim.cmd("delmarks " .. mark_name)
    end
  end

  -- Alsoacheck for global marks (A-Z, 0-9)
  local global_marks = vim.fn.getmarklist()
  for _, mark in ipairs(global_marks) do
    if mark.pos[2] == line and mark.pos[1] == vim.fn.bufnr() then
      local mark_name = string.sub(mark.mark, 2)
      vim.cmd("delmarks " .. mark_name)
    end
  end
  vim.notify "Removed marks on current line"
end, { desc = "Remove all marks on current line" })

-- Remove all marks in current buffer only
vim.keymap.set("n", "<leader>ram", function()
  vim.cmd "delmarks a-z" -- Only lowercase marks are buffer-local
  vim.notify "Removed all buffer-local marks"
end, { desc = "Remove all marks in current buffer" })

-- Remove all marks (including global marks)
vim.keymap.set("n", "<leader>ragm", function()
  vim.cmd "delmarks a-z" -- Buffer-local marks
  vim.cmd "delmarks A-Z" -- Global marks
  vim.cmd "delmarks 0-9" -- Number marks
  vim.notify "Removed all marks from everywhere"
end, { desc = "Remove all marks from everywhere" })

-- Mini.files mappings
local function toggle_mini_files()
  if not package.loaded["mini.files"] then
    require("mini.files").setup()
  end

  -- Check if mini.files is already open
  local is_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if buf_ft == "minifiles" then
      is_open = true
      break
    end
  end

  if is_open then
    require("mini.files").close()
    return
  end

  -- Open at current buffer's path
  local bufname = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.fnamemodify(bufname, ":p")
  if path and vim.uv.fs_stat(path) then
    require("mini.files").open(bufname, false)
  else
    vim.notify("current buffer file does not exist or path invalid", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<C-\\>", toggle_mini_files, { desc = "Toggle mini.files at current buffer's file" })
vim.keymap.set("n", "<leader>e", toggle_mini_files, { desc = "Toggle mini.files at current buffer's file" })
vim.keymap.set("x", "<CR>", "l", { remap = true, desc = "In mini.files, treat <CR> like l in visual mode" })

-- Buffer management mappings
vim.keymap.set({ "n", "i" }, "<F7>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

vim.keymap.set({ "n", "i" }, "<F8>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

vim.keymap.set("n", "<leader>cc", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

local function close_buffers_left()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Keep track of buffers we've seen
  local seen_current = false
  local buffers_to_close = {}

  -- Get all valid, listed buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "buflisted") and vim.api.nvim_buf_is_valid(buf) then
      if buf == current_buf then
        seen_current = true
        break -- Stop once we've found the current buffer
      else
        table.insert(buffers_to_close, buf)
      end
    end
  end

  -- Close all buffers that appeared before the current one
  for _, buf in ipairs(buffers_to_close) do
    require("nvchad.tabufline").close_buffer(buf)
  end
end

-- Updated close_buffers_right function
local function close_buffers_right()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Keep track of buffers we've seen
  local seen_current = false
  local buffers_to_close = {}

  -- Get all valid, listed buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "buflisted") and vim.api.nvim_buf_is_valid(buf) then
      if seen_current and buf ~= current_buf then
        table.insert(buffers_to_close, buf)
      elseif buf == current_buf then
        seen_current = true
      end
    end
  end

  -- Close all buffers that appeared after the current one
  for _, buf in ipairs(buffers_to_close) do
    require("nvchad.tabufline").close_buffer(buf)
  end
end

-- The close_other_buffers function is working correctly, so keep it as is
local function close_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Get list of buffers that NvChad considers valid
  local listed_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "buflisted") and vim.api.nvim_buf_is_valid(buf) then
      table.insert(listed_buffers, buf)
    end
  end

  -- Close all buffers except current using NvChad's close_buffer function
  for _, buf_id in ipairs(listed_buffers) do
    if buf_id ~= current_buf then
      require("nvchad.tabufline").close_buffer(buf_id)
    end
  end
end

vim.keymap.set("n", "<leader>cl", close_buffers_left, { desc = "Close buffers to the left" })
vim.keymap.set("n", "<leader>cr", close_buffers_right, { desc = "Close buffers to the right" })
vim.keymap.set("n", "<leader>co", close_other_buffers, { desc = "Close other buffers" })

-- Override <leader>x to close Telescope when in a Telescope prompt
local function close_telescope_or_buffer()
  -- Check if current buffer is a Telescope prompt
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_type = vim.api.nvim_buf_get_option(current_buf, "filetype")

  if buf_type == "TelescopePrompt" then
    -- If in Telescope, close Telescope
    require("telescope.actions").close(vim.api.nvim_get_current_buf())
  else
    -- If not in Telescope, use the regular close buffer function
    require("nvchad.tabufline").close_buffer()
  end
end

vim.keymap.set("n", "<leader>x", close_telescope_or_buffer, { desc = "Close buffer or Telescope" })
vim.keymap.set("n", "<leader>cc", close_telescope_or_buffer, { desc = "Close buffer or Telescope" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "v", "<BS>", "dgi", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt", 
  callback = function() 
    -- For Telescope: Select from cursor to beginning of input text, then press 'w'
    vim.api.nvim_buf_set_keymap(0, "i", "<S-Home>", "<C-O>v^w", { noremap = true, silent = true })
  end
})
