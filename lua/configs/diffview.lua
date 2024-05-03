local opts = {
  keymaps = {
    view = {
      ["q"] = "<Cmd>DiffviewClose<CR>",
      ["<C-w>"] = "<Cmd>DiffviewClose<CR>",
    },
    file_panel = {
      ["q"] = "<Cmd>DiffviewClose<CR>",
      ["<C-w>"] = "<Cmd>DiffviewClose<CR>",
    },
    file_history_panel = {
      ["q"] = "<Cmd>DiffviewClose<CR>",
      ["<C-w>"] = "<Cmd>DiffviewClose<CR>",
    },
  },
  hooks = {},
}

require("diffview").setup(opts)
