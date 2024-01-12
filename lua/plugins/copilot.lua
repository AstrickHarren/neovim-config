return {
  -- Copilots
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = "<tab>",
          accept_word = "<c-right>",
        },
      },
      panel = {
        enabled = false
      }
    },
  },

  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = { "zbirenbaum/copilot.lua", "yamatsum/nvim-nonicons" },
    lazy = true,
    event = "BufReadPost",
    opts = {},
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
