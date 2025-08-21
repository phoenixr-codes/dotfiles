local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.mcfunction = {
  install_info = {
    url = "~/Projects/tree-sitter-mcfunction",
    files = { "src/parser.c" },
    branch = "main",
  },
}
