return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh"
        }
      },
      color_icons = true,
      default = true,
      strict = true,
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        }
      },
      override_by_extension = {
        ["log"] = {
          icon = '',
          color = "#81e043",
          name = "Log"
        }
      },
    }

  },
  { "windwp/nvim-autopairs",                   opts = {} },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rust_tools = require('rust-tools')
      rust_tools.setup {}
      rust_tools.inlay_hints.enable()
    end,
    lazy = false
  },
  { "davidgranstrom/nvim-markdown-preview" },
  { "windwp/nvim-ts-autotag",                  opts = {} },
  { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      shortcut_type = 'number',
    },
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  { 'MunifTanjim/nui.nvim', },
  { 'rcarriga/nvim-notify', opts = {} },
  {
    'folke/noice.nvim',
    opts = {},
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  { 'folke/trouble.nvim', opts = { use_diagnostic_signs = true } }
}

-- vim: ts=2 sts=2 sw=2 et
