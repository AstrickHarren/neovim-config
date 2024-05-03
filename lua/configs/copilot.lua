local opts = {
  filetypes = {
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
