vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.signcolumn = "yes:2"
-- vim.opt.fillchars:append({ diff = "╱" })
vim.opt.fillchars:append({ diff = " " })

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

vim.cmd([[cnorea help vert help]])

--------- LSP signs ---------
local icons = require("nvim-nonicons")

local signs = {
	{ name = "DiagnosticSignError", text = icons.get("x-circle") },
	{ name = "DiagnosticSignWarn", text = icons.get("alert") },
	{ name = "DiagnosticSignHint", text = icons.get("question") },
	{ name = "DiagnosticSignInfo", text = icons.get("info") },
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
