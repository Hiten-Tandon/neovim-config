local transparent = false;

return {
  { 'navarasu/onedark.nvim', opts = { transparent = transparent }, },
  { 'folke/tokyonight.nvim', opts = { transparent = transparent }, },
  { 'Mofiqul/dracula.nvim',  opts = { transparent = transparent }, },
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
  },
  { 'Mofiqul/adwaita.nvim', },
  {
    'catppuccin/nvim',
    config = function()
      require('catppuccin').setup {
        transparent_background = transparent
      }
    end
  },
  { 'rebelot/kanagawa.nvim',        opts = { transparent = transparent, compile = true } },
  { 'morhetz/gruvbox' },
  { 'sainnhe/everforest' },
  { 'rose-pine/neovim',             name = 'rose-pine' },
  { 'Mofiqul/vscode.nvim',          opts = { transparent = transparent } },
  { 'rafi/awesome-vim-colorschemes' },
  {
    "hardhackerlabs/theme-vim",
    name = "hardhacker",
    init = function()
      vim.g.hardhacker_darker = 1
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
    end,
  }
}
-- vim: ts=2 sts=2 sw=2 et
