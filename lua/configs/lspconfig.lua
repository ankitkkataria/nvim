local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "clangd" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end

-- JDTLS specific setup
lspconfig.jdtls.setup({
  cmd = { 'jdtls' },
  root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
  settings = {
    java = {
      home = os.getenv('JAVA_HOME'),
    }
  }
})

vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})
