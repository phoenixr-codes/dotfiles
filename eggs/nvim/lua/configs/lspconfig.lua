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
vim.lsp.enable "java_language_server"

lspconfig("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable "jsonls"

lspconfig("ts_ls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  root_markers = { "package.json" },
  capabilities = nvlsp.capabilities,
  single_file_support = false,
})
vim.lsp.enable "ts_ls"

lspconfig("denols", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  --root_markers = { { "deno.json", "deno.jsonc" } },
  root_dir = function(bufnr, on_dir)
    -- HACK: This normally shouldn't be necessary and is required likely due to
    --       an issue in denols, ts_ls or vim.lsp. This snippet is copied from
    --       the default ts_ls.root_dir and modified appropriately. If this is
    --       not present, then denols is always preferred over ts_ls with the
    --       project root being nil. An alternative would be to manually start
    --       the LSPs accordingly but that would be very cumbersome.

    local root_markers = { "deno.json", "deno.jsonc" }
    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has "nvim-0.11.3" == 1 and { root_markers, { ".git" } }
      or vim.list_extend(root_markers, { ".git" })
    -- We fallback to the current working directory if no project root is found
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    on_dir(project_root)
  end,
})
vim.lsp.enable "denols"

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
vim.lsp.enable "taplo"
