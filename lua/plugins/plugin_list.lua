return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim",           enabled = false },
  { "OXY2DEV/markview.nvim" },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
  { "brenoprata10/nvim-highlight-colors", opts = {} },
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    opts = {
      watermark = "Hiten Tandon",
      title = "Code By Hiten Tandon",
      has_line_number = true,
      code_font_family = "JetBrains Mono Nerd Font",
      watermark_font_family = "JetBrains Mono Nerd Font",
    },
  },
}
