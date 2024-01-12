map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")

map("n", "gh", "0")
map("n", "gs", "_")
map("n", "gl", "$")
map("n", "ge", "G")

map("v", "gh", "0")
map("v", "gs", "_")
map("v", "gl", "$")
map("v", "ge", "G")

map("n", "<c-s>", ":w<cr>")
map("n", "<c-w>", "<cmd>x<cr>")
map("n", "q:", "<nop>")
map("n", "<c-q>", ":qa<cr>")
map("n", "<c-\\>", ":vs<cr>")
map("n", "U", "<c-r>")

map("t", "<c-j>", "<c-\\><c-n><cmd>ToggleTerm<cr>")
map("n", "<c-j>", "<cmd>ToggleTerm<cr><esc>")

map("n", "<leader>L", "<cmd>Lazy<cr>")

-- map("n", "w", "vw")
-- map("v", "w", "vw")
-- map("n", "b", "vb")
-- map("v", "b", "vb")

vim.cmd([[autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif]])
