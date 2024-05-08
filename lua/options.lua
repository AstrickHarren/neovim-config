require "nvchad.options"

-- add yours here!

vim.opt.swapfile = false
vim.opt.signcolumn = "yes:3"
vim.opt.fillchars = { diff = "╱", eob = " " }
vim.opt.relativenumber = true
vim.opt.diffopt:append "iwhiteall"
vim.opt.ph = 10 -- for cmp use

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

require "autocmds.diffview"
