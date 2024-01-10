function map(mode, lhs, rhs, opts)
  local options = {
    noremap = true,
    silent = true
  }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")
map("n", "gh", "0")
map("n", "gs", "_")
map("n", "gl", "$")
map("n", "ge", "G")
map("n", "<c-s>", ":w<cr>")
map("n", "<c-w>", ":x<cr>")
map("n", "q:", "<nop>")
map('n', '<c-q>', ':qa<cr>')
map('n', '<c-\\>', ':vs<cr>')
-- map("n", "w", "vw")
-- map("v", "w", "vw")
-- map("n", "b", "vb")
-- map("v", "b", "vb")
