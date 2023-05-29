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
    end
  },
  { "davidgranstrom/nvim-markdown-preview" },
  { "windwp/nvim-ts-autotag",                  lazy = true, opts = {} },
  { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
  { 'MunifTanjim/nui.nvim', },
  { 'rcarriga/nvim-notify',                    opts = {} },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  { 'folke/trouble.nvim',           opts = { use_diagnostic_signs = true } },
  { 'lvimuser/lsp-inlayhints.nvim', opts = {} },
  { 'mg979/vim-visual-multi', },
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require 'otter'.dev_setup {}
    end
  }
}

-- vim: ts=2 sts=2 sw=2 et
