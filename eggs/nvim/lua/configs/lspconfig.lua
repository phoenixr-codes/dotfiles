-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = vim.lsp.config

local servers = {
  "html",
  "cssls",
  "pylsp",
  "ruby_lsp",
  --"roc_ls",
  "vls",
  "ccls",
  "marksman",
  "pest_ls",
  "nim_langserver",
  "bashls",
  "tinymist",
  --"gleam",
  "zls",
  "nushell",
  "metals",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp)
end

lspconfig("java_language_server", {
  cmd = { "java-language-server" },
})
vim.lsp.enable("java_language_server")

lspconfig("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable("jsonls")

lspconfig("denols", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  root_markers = { { "deno.json", "deno.jsonc" } },
})
vim.lsp.enable("denols")

lspconfig("ts_ls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  root_markers = { "package.json" },
  capabilities = nvlsp.capabilities,
  single_file_support = false,
})
vim.lsp.enable("ts_ls")

lspconfig("taplo", {
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true, -- Enable schema support
        repositoryEnabled = true, -- Enable fetching schemas from the repository
      },
    },
  },
})
vim.lsp.enable("taplo")
