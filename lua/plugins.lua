return { {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
  end
}, {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'lua', 'rust' },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      }
    }
    map('n', '<c-n>', ':silent Neotree<CR>')
  end
}, {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim" }
}, {
  'windwp/nvim-autopairs',
  opts = {}
}
}
