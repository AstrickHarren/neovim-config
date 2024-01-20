map("n", "<c-h>", "<c-w>h", { desc = "Focus left window" })
map("n", "<c-l>", "<c-w>l", { desc = "Focus right window" })

map("n", "<c-s-k>", "<c-w>+", { desc = "Increase terminal height" })
map("t", "<c-s-k>", "<c-\\><c-n><c-w>+", { desc = "Increase terminal height" })
map("n", "<c-s-j>", "<c-w>-", { desc = "Decrease terminal height" })
map("t", "<c-s-j>", "<c-\\><c-n><c-w>-", { desc = "Decrease terminal height" })

map("n", "<c-s>", "<cmd>silent w<cr>")
map("n", "<c-q>", ":qa<cr>", { desc = "Quit all windows" })
map("n", "<c-\\>", ":vs<cr>", { desc = "Split window vertically" })
map("n", "U", "<c-r>", { desc = "Redo" })

vim.cmd("cnoremap <C-a> <Home>")
vim.cmd("cnoremap <C-b> <Left>")
vim.cmd("cnoremap <C-f> <Right>")
vim.cmd("cnoremap <C-s> <c-f>")
vim.cmd("cnoremap <M-b> <S-Left>")
vim.cmd("cnoremap <M-f> <S-Right>")

vim.cmd([[autocmd BufEnter *.txt if &buftype == 'help' | silent! wincmd L | endif]])
vim.cmd([[autocmd FocusGained,BufEnter * :silent! ! ]])

-- For some reason, gd is somehow set back to its default value after lazy vim mapping.
lazy_map("gd", "telescope.builtin", "lsp_definitions", { desc = "Go to definition", mode = { "n", "v" } })
map({ "n", "v" }, "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- vim.cmd([[cnorea help vert help]])

-- LSP Inlay hints
local function toggle_inlay_hint()
    local buf = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled(buf)
    local n_attached_clients = #vim.lsp.get_clients({ bufnr = buf })
    if n_attached_clients == 0 then
        return
    end
    vim.lsp.inlay_hint.enable(buf, not enabled)
end

-- map({ "n", "v" }, "<leader>li", toggle_inlay_hint, { desc = "Toggle inlay hints" })
map({ "i", "n", "v" }, "<c-t>", toggle_inlay_hint, { desc = "Toggle inlay hints" })
map({ "i", "n", "v" }, "<m-k>", toggle_inlay_hint, { desc = "Toggle inlay hints" })
