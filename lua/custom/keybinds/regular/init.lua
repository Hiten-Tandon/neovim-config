local terminal = 'nu' -- name of the terminal
return {
  -- {
  --    mode ([n]ormal, [v]isual, [i]nsert),
  --    keybind (as string),
  --    function (function or string),
  --    opts (mostly description)
  -- }
  { 'n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab [N]ew' } },          --opens a new tab
  { 'n', '<leader>hs', ':new<CR>',    { desc = '[H]orizontal [S]plit' } }, -- splits the screen horizontally
  { 'n', '<leader>vs', ':vnew<CR>',   { desc = '[V]ertical [S]plit' } },   -- splits the screen vertically
  { 'n', '<leader>ht',                                                     -- <space>ht opens a horizontal terminal
    function()
      vim.cmd [[10sp]]                                                     -- split at bottom for 10 rows
      vim.cmd('terminal ' .. terminal)                                     -- open the terminal
      vim.cmd [[
		setlocal norelativenumber
		setlocal nonumber
		startinsert
		nnoremap <buffer> <leader>ht :q<CR>
    ]]
    end,
    { desc = "[H]orizontal [T]erminal" }
  },
  { 'n', '<leader>vt',                 -- <space>ht opens a horizontal terminal
    function()
      vim.cmd [[60vsp]]                -- split at bottom for 10 rows
      vim.cmd('terminal ' .. terminal) -- open the terminal
      vim.cmd [[
		setlocal norelativenumber
		setlocal nonumber
		startinsert
		nnoremap <buffer> <leader>vt :q<CR>
    ]]
    end,
    { desc = "[V]ertical [T]erminal" }
  },
  { 'i', '<C-Del>', '<Esc>lcw', { desc = "Delete word" } },
  { 'n', '<C-Del>', '<Esc>dw',  { desc = "Delete word" } },
}
-- vim: ts=2 sts=2 sw=2 et
