local load_plugins = require("utils.loading").load_plugins
local M = {
  -- Editing
  "windwp/nvim-autopairs",
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },

  -- Navigation
  "nvim-telescope/telescope.nvim",
  { "nvim-tree/nvim-tree.lua", config = "nvim-tree" },

  -- UI
  { "j-hui/fidget.nvim", event = "BufRead" },
  { "stevearc/dressing.nvim", event = "VeryLazy", config = true },

  -- Lsp
  "neovim/nvim-lspconfig",
  "stevearc/conform.nvim",
  "hrsh7th/nvim-cmp",

  -- Git
  { "NeogitOrg/neogit", config = true },
  "sindrets/diffview.nvim",

  -- Task
  "stevearc/overseer.nvim",

  -- Copilot
  { "zbirenbaum/copilot.lua", event = "InsertEnter" },
  { "jonahgoldwastaken/copilot-status.nvim", event = "BufReadPost", config = "copilot-status" },

  -- Language Specifics
  { "chomosuke/typst-preview.nvim", ft = "typst", config = false },

  -- Disabled
  { "folke/which-key.nvim", config = false, enabled = false },
}

return load_plugins(M)
