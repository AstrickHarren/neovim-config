local U = require "utils"

local opts = {
  filetypes = {
    -- disable for .env files
    sh = U.filename:matches("^%.env.*"):eq(false).eval,
    markdown = true,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<c-f>",
      accept_word = "<c-right>",
      accept_line = "<c-down>",
    },
  },
  panel = {
    enabled = false,
  },
}

require("copilot").setup(opts)
