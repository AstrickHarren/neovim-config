return {
  "sindrets/diffview.nvim",
  opts = {},
  keys = {
    {
      "<leader>dd",
      "<cmd>DiffviewOpen<cr>",
      desc = "Open diffview",
    },
    {
      "<esc>",
      "<cmd>DiffviewClose<cr>",
      desc = "Close diffview",
    },
    {
      "<leader>dH",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "All file history",
    },
    {
      "<leader>dh",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "Current file history",
    },
  },
}
