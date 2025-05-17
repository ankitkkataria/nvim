local lspconfig = require("lspconfig")

local servers = { "html", "cssls" , "clangd"}

for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end
