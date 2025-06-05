-- local dap = require('dap')
-- local dapui = require('dapui')
-- local dap_mason = require('mason-nvim-dap')
--
-- -- 1. Configure nvim-dap-ui
-- dapui.setup({
--   elements = {
--     {
--       id = "scopes",
--       size = 0.25,
--     },
--     {
--       id = "breakpoints",
--       size = 0.25,
--     },
--     {
--       id = "stacks",
--       size = 0.25,
--     },
--     {
--       id = "watches",
--       size = 0.25,
--     },
--   },
--   layouts = {
--     {
--       elements = {
--         { id = "scopes", size = 0.30 },
--         { id = "breakpoints", size = 0.20 },
--         { id = "stacks", size = 0.25 },
--         { id = "watches", size = 0.25 },
--       },
--       size = 40,
--       position = "left",
--     },
--     {
--       elements = {
--         { id = "repl", size = 0.5 },
--         { id = "console", size = 0.5 },
--       },
--       size = 0.25,
--       position = "bottom",
--     },
--   },
--   floating = {
--     max_height = nil,
--     max_width = nil,
--     border = "single",
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   controls = {
--     enabled = true,
--   },
--   icons = {
--     expanded = "",
--     collapsed = "",
--     current_frame = "",
--   },
-- })
--
-- -- 2. Configure mason-nvim-dap for C++ only
-- dap_mason.setup({
--   ensure_installed = { "cpptools" },
--   handlers = {
--     cpptools = function(config)
--       dap.adapters.cpptools = {
--         type = 'server',
--         host = config.host or '127.0.0.1',
--         port = config.port or '${port}',
--         executable = {
--           command = config.path,
--           args = config.args or {},
--         },
--         options = {
--           source_filetype = { "cpp", "c" },
--         },
--       }
--     end,
--   },
-- })
--
-- -- 3. C++ DAP configurations
-- dap.configurations.cpp = {
--   {
--     name = "Launch C++ Program",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       -- Smart path detection for common C++ build patterns
--       local cwd = vim.fn.getcwd()
--       local suggestions = {
--         cwd .. '/build/main',
--         cwd .. '/build/' .. vim.fn.fnamemodify(cwd, ':t'),
--         cwd .. '/a.out',
--         cwd .. '/main',
--       }
--
--       -- Check if any of the common paths exist
--       for _, path in ipairs(suggestions) do
--         if vim.fn.executable(path) == 1 then
--           local use_suggestion = vim.fn.confirm(
--             'Found executable: ' .. path .. '\nUse this?', 
--             '&Yes\n&No\n&Browse', 
--             1
--           )
--           if use_suggestion == 1 then
--             return path
--           elseif use_suggestion == 3 then
--             break
--           end
--         end
--       end
--
--       return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtEntry = false,
--     externalConsole = false,
--     MIMode = "gdb", -- Change to "lldb" if you prefer lldb
--     setupCommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "Enable pretty printing for STL containers",
--         ignoreFailures = true
--       },
--       {
--         text = "-gdb-set print object on",
--         description = "Show object types in output",
--         ignoreFailures = true
--       },
--     },
--     -- Arguments to pass to your program
--     args = function()
--       local args_string = vim.fn.input('Program arguments: ')
--       return vim.split(args_string, " ", true)
--     end,
--   },
--   {
--     name = "Launch C++ Program (No Args)",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtEntry = false,
--     externalConsole = false,
--     MIMode = "gdb",
--     setupCommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "Enable pretty printing for STL containers",
--         ignoreFailures = true
--       },
--     },
--   },
--   {
--     name = "Attach to Process",
--     type = "cppdbg",
--     request = "attach",
--     program = function()
--       return vim.fn.input('Path to executable (for symbols): ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     processId = require('dap.utils').pick_process,
--     cwd = "${workspaceFolder}",
--     MIMode = "gdb",
--     setupCommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "Enable pretty printing",
--         ignoreFailures = true
--       },
--     },
--   },
-- }
--
-- -- C configurations use the same as C++
-- dap.configurations.c = dap.configurations.cpp
--
-- -- 4. Automatic UI management
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
--
-- -- 5. C++ optimized keymaps
-- local function map(mode, lhs, rhs, opts)
--   opts = opts or {}
--   opts.noremap = true
--   opts.silent = true
--   vim.keymap.set(mode, lhs, rhs, opts)
-- end
--
-- -- Core debugging commands
-- map('n', '<leader>db', dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
-- map('n', '<leader>dB', function() 
--   dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
-- end, { desc = "DAP: Conditional Breakpoint" })
-- map('n', '<leader>dc', dap.continue, { desc = "DAP: Continue/Start" })
-- map('n', '<leader>dr', dap.terminate, { desc = "DAP: Terminate" })
-- map('n', '<leader>dR', dap.restart, { desc = "DAP: Restart" })
--
-- -- Stepping commands
-- map('n', '<leader>dso', dap.step_over, { desc = "DAP: Step Over (F10)" })
-- map('n', '<leader>dsi', dap.step_into, { desc = "DAP: Step Into (F11)" })
-- map('n', '<leader>dpo', dap.step_out, { desc = "DAP: Step Out (Shift+F11)" })
--
-- -- Alternative F-key bindings (common in other IDEs)
-- map('n', '<F5>', dap.continue, { desc = "DAP: Continue/Start" })
-- map('n', '<F10>', dap.step_over, { desc = "DAP: Step Over" })
-- map('n', '<F11>', dap.step_into, { desc = "DAP: Step Into" })
-- map('n', '<S-F11>', dap.step_out, { desc = "DAP: Step Out" })
-- map('n', '<S-F5>', dap.terminate, { desc = "DAP: Terminate" })
--
-- -- Quick launch (uses first configuration)
-- map('n', '<leader>dl', function() 
--   dap.run(dap.configurations.cpp[1]) 
-- end, { desc = "DAP: Launch C++ Program" })
--
-- -- DAP-UI commands
-- map('n', '<leader>duo', dapui.open, { desc = "DAP UI: Open" })
-- map('n', '<leader>duc', dapui.close, { desc = "DAP UI: Close" })
-- map('n', '<leader>dut', dapui.toggle, { desc = "DAP UI: Toggle" })
--
-- -- Variable inspection
-- map('n', '<leader>dwe', dapui.eval, { desc = "DAP: Evaluate Word Under Cursor" })
-- map('v', '<leader>dwe', dapui.eval, { desc = "DAP: Evaluate Selection" })
-- map('n', '<leader>dh', function()
--   require('dap.ui.widgets').hover()
-- end, { desc = "DAP: Hover Variables" })
--
-- -- Advanced features
-- map('n', '<leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end, { desc = "DAP: Show Scopes" })
--
-- map('n', '<leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end, { desc = "DAP: Show Frames" })
--
-- -- Clear all breakpoints
-- map('n', '<leader>dcl', function()
--   dap.clear_breakpoints()
--   print("All breakpoints cleared")
-- end, { desc = "DAP: Clear All Breakpoints" })
--
-- -- Set up visual signs for breakpoints
-- vim.fn.sign_define('DapBreakpoint', {
--   text = '🔴',
--   texthl = 'DiagnosticError',
--   linehl = '',
--   numhl = ''
-- })
--
-- vim.fn.sign_define('DapBreakpointCondition', {
--   text = '🟡',
--   texthl = 'DiagnosticWarn',
--   linehl = '',
--   numhl = ''
-- })
--
-- vim.fn.sign_define('DapStopped', {
--   text = '➡️',
--   texthl = 'DiagnosticInfo',
--   linehl = 'DapStoppedLine',
--   numhl = ''
-- })
--
-- -- Highlight for the current line when stopped
-- vim.cmd [[
--   hi DapStoppedLine guibg=#2e4d32
-- ]]
--
-- -- Utility function to compile and debug in one command
-- vim.api.nvim_create_user_command('CppDebug', function()
--   local current_file = vim.fn.expand('%:p')
--   local output_file = vim.fn.expand('%:r') -- filename without extension
--
--   -- Compile with debug symbols
--   local compile_cmd = string.format('g++ -g -o %s %s', output_file, current_file)
--
--   -- Run compilation
--   local compile_result = vim.fn.system(compile_cmd)
--
--   if vim.v.shell_error == 0 then
--     print("Compilation successful!")
--     -- Set the program path and start debugging
--     dap.configurations.cpp[1].program = output_file
--     dap.run(dap.configurations.cpp[1])
--   else
--     print("Compilation failed:")
--     print(compile_result)
--   end
-- end, { desc = "Compile current C++ file and start debugging" })


local dap = require('dap')
local dapui = require('dapui')

-- 1. Configure nvim-dap-ui
dapui.setup({
  elements = {
    {
      id = "scopes",
      size = 0.25,
    },
    {
      id = "breakpoints",
      size = 0.25,
    },
    {
      id = "stacks",
      size = 0.25,
    },
    {
      id = "watches",
      size = 0.25,
    },
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.30 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 0.25,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  controls = {
    enabled = true,
  },
  icons = {
    expanded = "",
    collapsed = "",
    current_frame = "",
  },
})

-- 2. Setup cpptools adapter manually
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
}

-- 3. C++ DAP configurations
dap.configurations.cpp = {
  {
    name = "Launch C++ Program",
    type = "cppdbg",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local suggestions = {
        cwd .. '/encrypt_decrypt',
        cwd .. '/cryption',
        cwd .. '/build/main',
        cwd .. '/a.out',
        cwd .. '/main',
      }
      
      for _, path in ipairs(suggestions) do
        if vim.fn.executable(path) == 1 then
          local use_suggestion = vim.fn.confirm(
            'Found executable: ' .. path .. '\nUse this?', 
            '&Yes\n&No\n&Browse', 
            1
          )
          if use_suggestion == 1 then
            return path
          elseif use_suggestion == 3 then
            break
          end
        end
      end
      
      return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing for STL containers",
        ignoreFailures = true
      },
      {
        text = "-gdb-set print object on",
        description = "Show object types in output",
        ignoreFailures = true
      },
    },
    args = function()
      local args_string = vim.fn.input('Program arguments: ')
      return vim.split(args_string, " ", true)
    end,
  },
  {
    name = "Launch C++ Program (No Args)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing for STL containers",
        ignoreFailures = true
      },
    },
  },
}

-- C configurations use the same as C++
dap.configurations.c = dap.configurations.cpp

-- 4. Automatic UI management
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- 5. Keymaps
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Core debugging commands
map('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map('n', '<leader>dB', function() 
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end, { desc = "Conditional Breakpoint" })
map('n', '<leader>dc', dap.continue, { desc = "Continue/Start" })
map('n', '<leader>dr', dap.terminate, { desc = "Terminate" })

-- Stepping
map('n', '<leader>dso', dap.step_over, { desc = "Step Over" })
map('n', '<leader>dsi', dap.step_into, { desc = "Step Into" })
map('n', '<leader>dpo', dap.step_out, { desc = "Step Out" })

-- F-keys
map('n', '<F5>', dap.continue, { desc = "Continue/Start" })
map('n', '<F10>', dap.step_over, { desc = "Step Over" })
map('n', '<F11>', dap.step_into, { desc = "Step Into" })
map('n', '<S-F11>', dap.step_out, { desc = "Step Out" })
map('n', '<S-F5>', dap.terminate, { desc = "Terminate" })

-- UI
map('n', '<leader>dut', dapui.toggle, { desc = "Toggle DAP UI" })
map('n', '<leader>dwe', dapui.eval, { desc = "Evaluate" })
map('v', '<leader>dwe', dapui.eval, { desc = "Evaluate Selection" })

-- Clear breakpoints
map('n', '<leader>dl', function()
  dap.clear_breakpoints()
  print("All breakpoints cleared")
end, { desc = "Clear All Breakpoints" })

-- Visual signs
vim.fn.sign_define('DapBreakpoint', {
  text = '🔴',
  texthl = 'DiagnosticError',
  linehl = '',
  numhl = ''
})

vim.fn.sign_define('DapStopped', {
  text = '➡️',
  texthl = 'DiagnosticInfo',
  linehl = 'DapStoppedLine',
  numhl = ''
})

vim.cmd [[
  hi DapStoppedLine guibg=#2e4d32
]]
