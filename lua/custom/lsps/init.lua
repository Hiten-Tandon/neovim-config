return {
  clangd = {},   -- C, C++
  gopls = {},    -- Go
  ruff_lsp = {}, -- Python
  pyright = {},  -- Python
  rust_analyzer = {
    -- Rust
    imports = {
      granularity = {
        group = 'module',
      },
      prefix = 'self',
    },
    procMacro = {
      enable = true
    },
    checkOnSave = {
      command = 'clippy'
    },
    dependencies = { 'simrat39\rust-tools.nvim' }
  },
  tsserver = {}, --TS, JS, HTML, ...

  lua_ls = {
    -- lua
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  zls = {},                                                                              --zig
  marksman = { dependencies = { 'davidgranstrom/nvim-markdown-preview', lazy = true }, } --markdown
}

-- vim: ts=2 sts=2 sw=2 et
