return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      styles = {
        comments = { "italic" },
        functions = { "bold" },
      },
      integrations = { treesitter = true },
    },
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },
}
