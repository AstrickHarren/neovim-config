local opts = {
  projects = { -- define project roots
    "~/Repositories/*",
    "~/.config/*",
  },
}

require("neovim-project").setup(opts)
