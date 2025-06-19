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
-- vim.keymap.set("n", "<F9>", ":noh<cr>")
vim.keymap.set({ "n", "v" }, "mb", "%")

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
-- vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "c", '"_c')

-- EasyMotion Settings
local hop = require "hop"
vim.keymap.set("", "s", function()
  hop.hint_char1()
end, { remap = true })

vim.keymap.set("", "<leader>l", function()
  hop.hint_lines_skip_whitespace()
end, { remap = true })

-- Select text with Shift + left, right arrow keys in Insert mode
vim.api.nvim_set_keymap("i", "<S-Left>", "<C-O>vh", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Right>", "<C-O>vl", { noremap = true, silent = true })

-- Select text to the beginning and end of the line with Shift + Home/End in Insert mode
vim.api.nvim_set_keymap("i", "<S-Home>", "<C-O>v^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-End>", "<C-O>v$", { noremap = true, silent = true })

-- Delete selected text with Backspace in Visual mode and go to Insert mode
vim.api.nvim_set_keymap("v", "<BS>", "dgi", { noremap = true, silent = true })

-- Indenting selected text and even after that we shall stay in visual mode so we can further indent
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Alternate mappings for Indenting code in visual mode
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
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
vim.api.nvim_set_keymap("n", "<leader>j", "mzJ`z", { noremap = true, silent = true })

-- For toggling line wrap
vim.keymap.set("n", "<leader>wl", "<cmd>set wrap!<CR>")

-- nvimtree
-- vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Floating terminals mappings
-- Vertcal Terminal
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

-- Horizontal Terminal
vim.keymap.set({ "n", "t" }, "<C-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- Persistent terminal (Search through open terminals using <leader>pt)
vim.keymap.set("n", "<leader>ht", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

vim.keymap.set("n", "<leader>vt", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

vim.keymap.set("t", "jj", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- Toggle diagnostics
vim.keymap.set("n", "<leader>tt", function()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config().virtual_text,
  }
end, { desc = "Toggle inline diagnostics" })

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

vim.keymap.set("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>cc", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>co", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close other buffers" })

vim.keymap.set("n", "<leader>ca", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "Close all buffers" })

vim.keymap.set("n", "<leader>cl", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "Close buffers to the left" })

vim.keymap.set("n", "<leader>cr", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "Close buffers to the right" })

-- Telescope mappings
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
vim.keymap.set(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "telescope find in current buffer" }
)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
vim.keymap.set("n", "<leader>gbc", "<cmd>Telescope git_bcommits<CR>", { desc = "Buffer Git Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
vim.keymap.set("n", "<leader>wk", "<cmd>Telescope keymaps<CR>", { desc = "Find Keymaps" })

vim.keymap.set("n", "<leader>cd", function()
  require("telescope").extensions.zoxide.list()
end, { desc = "Change Directory (zoxide)" })

vim.keymap.set("n", "<leader>gi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
vim.keymap.set("x", "<leader>gi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })

-- vim.keymap.set(
--   "n",
--   "<leader>fg",
--   "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
--   { desc = "Live Grep" }
-- )

local function toggle_telescope()
  if vim.bo.filetype == "TelescopePrompt" then
    require("telescope.actions").close(vim.api.nvim_get_current_buf())
  else
    require("telescope.builtin").find_files {
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-p>", function()
          require("telescope.actions").close(prompt_bufnr)
        end)
        map("n", "<C-p>", function()
          require("telescope.actions").close(prompt_bufnr)
        end)
        return true
      end,
    }
  end
end

-- Close any telescope window with C-p
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("i", "<C-p>", function()
      require("telescope.actions").close(event.buf)
    end, opts)
    vim.keymap.set("n", "<C-p>", function()
      require("telescope.actions").close(event.buf)
    end, opts)
  end,
})

vim.keymap.set("n", "<C-p>", toggle_telescope, { desc = "Toggle telescope find files" })
vim.keymap.set("i", "<C-p>", toggle_telescope, { desc = "Toggle telescope find files" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "v", "<BS>", "dgi", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", "<S-Home>", "<C-O>v^w", { noremap = true, silent = true })
  end,
})

-- Function to close telescope
local function close_telescope()
  vim.cmd "close!"
end

-- Set up telescope close keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.keymap.set("n", "<leader>x", close_telescope, { buffer = true, desc = "Close telescope" })
    vim.keymap.set("n", "<leader>cc", close_telescope, { buffer = true, desc = "Close telescope" })
  end,
})

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { desc = "Undo telescope picker" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Resume last telescope picker" })
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope spell_suggest<CR>", { desc = "Spell suggestions" })

-- Miscellaneous mappings
-- Copy current file path to clipboard
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify("Copied path: " .. path, vim.log.levels.INFO)
end, { desc = "Copy file path to clipboard" })

-- Copy current file's name
vim.keymap.set("n", "<leader>yn", function()
  local name = vim.fn.expand "%:t"
  vim.fn.setreg("+", name)
  vim.notify("Copied filename: " .. name, vim.log.levels.INFO)
end, { desc = "Copy filename to clipboard" })

vim.keymap.set("n", "<leader>mx", function()
  local file = vim.fn.expand "%"
  local perms = vim.fn.getfperm(file)
  local is_executable = string.match(perms, "x", -1) ~= nil
  local escaped_file = vim.fn.shellescape(file)
  if is_executable then
    vim.cmd("silent !chmod -x " .. escaped_file)
    vim.notify("Removed executable permission", vim.log.levels.INFO)
  else
    vim.cmd("silent !chmod +x " .. escaped_file)
    vim.notify("Added executable permission", vim.log.levels.INFO)
  end
end, { desc = "Toggle executable permission" })

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

-- By default, CTRL-U and CTRL-D scroll by half a screen (50% of the window height)
-- Scroll by 25% of the window height and keep the cursor centered
local scroll_percentage = 0.25
-- Scroll by a percentage of the window height and keep the cursor centered
vim.keymap.set("n", "<C-d>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "jzz")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "kzz")
end, { noremap = true, silent = true })
