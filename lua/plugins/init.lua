local load_plugins = require("loading").load_plugins
local M = {
  "stevearc/conform.nvim",
  "neovim/nvim-lspconfig",
  "nvim-telescope/telescope.nvim",

  "windwp/nvim-autopairs",
  { "j-hui/fidget.nvim", event = "BufRead" },
  { "zbirenbaum/copilot.lua", event = "InsertEnter" },
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  { "stevearc/dressing.nvim", event = "VeryLazy", config = true },

  "hrsh7th/nvim-cmp",

  -- Git
  { "NeogitOrg/neogit", config = true },
  "sindrets/diffview.nvim",

  -- Task
  "stevearc/overseer.nvim",

  -- disabled
  { "folke/which-key.nvim", config = false, enabled = false },
}

return load_plugins(M)
