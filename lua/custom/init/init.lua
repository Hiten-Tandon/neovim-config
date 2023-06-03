vim.cmd [[colorscheme ayu]] -- theme you wanna use
--                                    because it fixes a bug,
--                                    you don't need this for any other theme
vim.cmd [[set number]]                                                           -- enables numbering
vim.cmd [[set relativenumber]]                                                   -- enables numbering relative to the lines
local terminal = 'nu'                                                            -- name of the terminal

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab [N]ew' })       -- open a new tab
vim.keymap.set('n', '<leader>hs', ':new<CR>', { desc = '[H]orizontal [S]plit' }) -- split the screen horizontally
vim.keymap.set('n', '<leader>vs', ':vnew<CR>', { desc = '[V]ertical [S]plit' })  -- split the screen vertically
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
vim.keymap.set('i', '<C-Del>', '<Esc>lcw', { desc = "Delete word" })
vim.keymap.set('n', '<C-Del>', '<Esc>dw', { desc = "Delete word" })

local inlayhint_exempt = { 'rust_analyzer' }; -- Names of LSPs which should be exempted from inlayhints from this plugin

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    for _, name in ipairs(inlayhint_exempt) do
      if client.name == name then
        return
      end
    end

    require("lsp-inlayhints").on_attach(client, bufnr, false)
  end,
})

-- vim: ts=2 sts=2 sw=2 et
