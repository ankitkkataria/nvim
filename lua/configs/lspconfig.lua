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
