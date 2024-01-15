map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")

map("n", "gh", "0", { desc = "Move to the start of the line" })
map("n", "gs", "_", { desc = "Move to the start of the line without indent" })
map("n", "gl", "$", { desc = "Move to the end of the line" })
map("n", "ge", "G", { desc = "Move to the end of the file" })

map("v", "gh", "0", { desc = "Move to the start of the line" })
map("v", "gs", "_", { desc = "Move to the start of the line without indent" })
map("v", "gl", "$", { desc = "Move to the end of the line" })
map("v", "ge", "G", { desc = "Move to the end of the file" })

map("n", "<c-s>", "<cmd>silent w<cr>")
map("n", "<c-w>", "<cmd>x<cr>")
map("n", "q:", "<nop>")
map("n", "<c-q>", ":qa<cr>")
map("n", "<c-\\>", ":vs<cr>")
map("n", "U", "<c-r>")

map("t", "<c-j>", "<c-\\><c-n><cmd>ToggleTerm<cr>")
map("n", "<c-j>", "<cmd>ToggleTerm<cr><esc>")

map("n", "<leader>L", "<cmd>Lazy<cr>")

vim.cmd("cnoremap <C-a> <Home>")
vim.cmd("cnoremap <C-b> <Left>")
vim.cmd("cnoremap <C-f> <Right>")
vim.cmd("cnoremap <C-s> <c-f>")
vim.cmd("cnoremap <M-b> <S-Left>")
vim.cmd("cnoremap <M-f> <S-Right>")

-- map("n", "w", "vw")
-- map("v", "w", "vw")
-- map("n", "b", "vb")
-- map("v", "b", "vb")

vim.cmd([[autocmd BufEnter *.txt if &buftype == 'help' | silent! wincmd L | endif]])
vim.cmd([[autocmd FocusGained,BufEnter * :silent! ! ]])

-- local telescope = require("telescope.builtin")
-- map("n", "gd", telescope.lsp_definitions, { desc = "Go to definition" })

-- vim.cmd([[cnorea help vert help]])
