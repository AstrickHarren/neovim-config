local opts = require "nvchad.configs.treesitter"

opts.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<CR>",
    scope_incremental = "<Tab>",
    node_incremental = "<CR>",
    node_decremental = "<S-CR>",
  },
}

dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "treesitter")
require("nvim-treesitter.configs").setup(opts)
-- require("nvim-treesitter").setup(opts)
