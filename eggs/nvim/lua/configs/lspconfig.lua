-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  pylsp = {},
  ruby_lsp = {},
  vls = {},
  ccls = {},
  marksman = {},
  pest_ls = {},
  nim_langserver = {},
  bashls = {},
  tinymist = {},
  zls = {},
  metals = {},

  java_language_server = {
    cmd = { "java-language-server" },
  },

  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  ts_ls = {
    root_markers = { "package.json" },
    single_file_support = false,
  },

  denols = {
    root_markers = { { "deno.json", "deno.jsonc" } },
  },

  taplo = {
    settings = {
      evenBetterToml = {
        schema = {
          enabled = true, -- Enable schema support
          repositoryEnabled = true, -- Enable fetching schemas from the repository
        },
      },
    },
  },

  nushell = {
    cmd = {
      "nu",
      "--lsp",
      "--no-config-file", -- see also: https://github.com/helix-editor/helix/discussions/12660
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
