local regular_kbs = require 'custom.keybinds.regular'


for _, v in pairs(regular_kbs) do
  vim.keymap.set(v[1], v[2], v[3], v[4])
end


-- vim: ts=2 sts=2 sw=2 et
