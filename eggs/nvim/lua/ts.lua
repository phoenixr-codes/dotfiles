local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.mcfunction = {
  install_info = {
    url = "~/Projects/tree-sitter-mcfunction",
    files = { "src/parser.c" },
    branch = "main",
    queries = "queries",
  },
}

parsers.rhai = {
  install_info = {
    url = "https://github.com/elkowar/tree-sitter-rhai.git",
    files = { "src/parser.c" },
    branch = "main",
    queries = "queries",
  },
}
