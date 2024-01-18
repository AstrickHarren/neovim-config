vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.signcolumn = "yes:2"
-- vim.opt.fillchars:append({ diff = "╱" })
vim.opt.fillchars:append({ diff = " " })
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

vim.opt.pumheight = 10
vim.opt.pumwidth = 60

-- Hide tab line and command/status line
vim.opt.showtabline = 0
vim.opt.showmode = false
-- vim.opt.cmdheight = 0

-- Normal mode block, insert-like mode and command mode vertical line, replace-like mode underline
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.opt.splitright = true

--------- LSP signs ---------
local icons = require("nvim-nonicons")

local signs = {
    { name = "DiagnosticSignError", text = icons.get("x-circle") },
    { name = "DiagnosticSignWarn",  text = icons.get("alert") },
    { name = "DiagnosticSignHint",  text = icons.get("question") },
    { name = "DiagnosticSignInfo",  text = icons.get("info") },
}

local signs = lsp_signs(icons)
for _, sign in pairs(signs) do
    vim.fn.sign_define(sign.hl, { texthl = sign.hl, text = sign.icon })
end

vim.diagnostic.config({
    underline = true,
    severity_sort = true,
    signs = true,
    update_in_insert = false,
})

-- listchars=tab:->,space:.
-- vim.opt.list = true
vim.opt.listchars = { space = ".", tab = " " }
