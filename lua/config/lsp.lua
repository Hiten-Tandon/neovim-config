vim.lsp.start({
  name = "uiua-server",
  cmd = { "uiua lsp" },
  root_dir = vim.fs.dirname(vim.fs.find("main.uiua", { upward = true })[1]),
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config["uiua"] = {
  install_info = {
    url = "https://github.com/shnarazk/tree-sitter-uiua", -- local path or git repo
    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype = "ua", -- if filetype does not match the parser name
}
