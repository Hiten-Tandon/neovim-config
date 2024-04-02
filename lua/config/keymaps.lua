-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ht", function()
  vim.cmd([[
  10sp]])
  vim.cmd.terminal("nu")
  vim.cmd([[
  setlocal nonumber norelativenumber
  startinsert
  nnoremap <buffer> <leader>ht :q<CR>
  ]])
end, { desc = "[H]orizontal [T]erminal" })

vim.keymap.set("n", "<leader>vt", function()
  vim.cmd([[
  60vsp]])
  vim.cmd.terminal("nu")
  vim.cmd([[
  setlocal nonumber norelativenumber
  startinsert
  nnoremap <buffer> <leader>ht :q<CR>
  ]])
end, { desc = "[V]ertical [T]erminal" })

-- Open compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap(
  "n",
  "<S-F6>",
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
    .. "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true }
)

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
