local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = { "prettier" },
    javascript = { "prettier" },
    java = { "astyle" },
    python = {
      "isort", -- see also: https://docs.astral.sh/ruff/formatter/#sorting-imports
      "ruff"
    },
    nim = { "nimpretty" },
    typst = { "typstyle" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
