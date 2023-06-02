local transparent = false;

return {
  { 'navarasu/onedark.nvim', opts = { transparent = transparent }, lazy = true },
  { 'folke/tokyonight.nvim', opts = { transparent = transparent }, lazy = true },
  { 'Mofiqul/dracula.nvim',  opts = { transparent = transparent }, lazy = true },
  {
    'EdenEast/nightfox.nvim',
    opts = {
      options = {
        transparent = transparent,
        styles = {
          types = "italic",
          keywords = "italic",
          comments = "italic"
        }
      }
    },
    lazy = true
  },
  { 'Mofiqul/adwaita.nvim',         lazy = true },
  {
    'catppuccin/nvim',
    config = function()
      require('catppuccin').setup {
        transparent_background = transparent
      }
    end,
    lazy = true
  },
  { 'rebelot/kanagawa.nvim',        opts = { transparent = transparent, compile = true }, lazy = true },
  { 'morhetz/gruvbox',              lazy = true },
  { 'sainnhe/everforest',           lazy = true },
  { 'rose-pine/neovim',             name = 'rose-pine',                                   lazy = true },
  { 'Mofiqul/vscode.nvim',          opts = { transparent = transparent },                 lazy = true },
  { 'rafi/awesome-vim-colorschemes' },
  {
    "hardhackerlabs/theme-vim",
    name = "hardhacker",
    init = function()
      vim.g.hardhacker_darker = 1
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
    end,
    lazy = true
  }
}
-- vim: ts=2 sts=2 sw=2 et
