local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "clangd", "pylsp", "ts_ls" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end

-- sudo apt install -y python3-venv (incase you get an error while doing MasonInstallAll)
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        pylsp_black = { enabled = true},
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = false},
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pylsp_isort = { enabled = false},
        -- Extra
        mccabe = { enabled = false },
      },
    },
  },
}

-- JDTLS specific setup
-- lspconfig.jdtls.setup({
--   cmd = { 'jdtls' },
--   root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
--   settings = {
--     java = {
--       home = os.getenv('JAVA_HOME'),
--     }
--   }
-- })

vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})

vim.diagnostic.config(
  {
    underline = false,
    virtual_text = false,
    update_in_insert = false,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      }
    }
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})
