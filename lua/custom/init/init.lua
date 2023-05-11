vim.cmd [[colorscheme carbonfox]]              -- theme you wanna use
vim.cmd [[colorscheme carbonfox]]              -- the statement is repeated second time,
--                                                    because it fixes a bug, you don't need this for any other theme
vim.cmd [[set number]]                         -- enables numbering
vim.cmd [[set relativenumber]]                 -- enables numbering relative to the lines
vim.diagnostic.config { virtual_text = false } -- comment this line if you plan to disable lsp-lines

--name of the terminal, if you use powershell, pwsh, or blank for default
local terminal = 'nu'

vim.keymap.set('n', '<leader>hs', ':new<CR>', { desc = '[H]orizontal [S]plit' }) -- split the screen horizontally
vim.keymap.set('n', '<leader>vs', ':vnew<CR>', { desc = '[V]ertical [S]plit' })  --split the screen vertically
vim.keymap.set('n', '<leader>ht',                                                -- <space>ht opens a horizontal terminal
  function()
    vim.cmd [[10sp]]                                                             -- split at bottom for 10 rows
    vim.cmd('terminal ' .. terminal)                                             -- open the terminal
    vim.cmd [[
		setlocal norelativenumber
		setlocal nonumber
		startinsert
		nnoremap <buffer> <leader>ht :q<CR>
		]]
  end,
  { desc = "[H]orizontal [T]erminal" }
)


vim.keymap.set('n', '<leader>vt',    -- <space>vt opens a vertical terminal, this command makes that possible
  function()
    vim.cmd [[60vsp]]                -- split at right for 60 columns
    vim.cmd('terminal ' .. terminal) -- open the terminal
    vim.cmd [[
		setlocal nonumber
		setlocal norelativenumber
		startinsert
		nnoremap <buffer> <leader>vt :q<CR>
		]]
  end,
  { desc = "[V]ertical [T]erminal" }
)


-- vim: ts=2 sts=2 sw=2 et
