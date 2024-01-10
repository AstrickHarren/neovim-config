vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.signcolumn = "yes"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd('set autoread')

--------- LSP signs --------- 
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  signs = true,
  update_in_insert = false,
})
