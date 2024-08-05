local lsp = require("lspconfig")

vim.tbl_deep_extend("keep", lsp, {
  nu = {
    cmd = { "nu", "--lsp" },
    filetypes = "nu",
    name = "nu",
  },
})
