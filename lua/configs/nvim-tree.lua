local opts = require "nvchad.configs.nvimtree"

opts.renderer.highlight_git = false
opts.renderer.highlight_diagnostics = true
opts.renderer.icons.glyphs.git.unstaged = ""
opts.diagnostics = { enable = true, icons = {
  hint = "",
  info = "",
  warning = "",
  error = "",
} }
require("nvim-tree").setup(opts)
