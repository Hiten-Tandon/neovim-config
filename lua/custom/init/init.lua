vim.cmd [[colorscheme carbonfox]] -- theme you wanna use
--                                    because it fixes a bug,
--                                    you don't need this for any other theme
vim.cmd [[set number]]         -- enables numbering
vim.cmd [[set relativenumber]] -- enables numbering relative to the lines

require 'custom.keybinds'

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
