return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "muniftanjim/nui.nvim" },
  },

  { "windwp/nvim-autopairs",   opts = {} },
  { "tpope/vim-surround" },
  -- { "wellle/targets.vim" },

  { "akinsho/toggleterm.nvim", opts = {} },

  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },

  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = { line = "<c-/>" },
      opleader = { line = "<c-/>" },
    },
    lazy = false,
    keys = {},
  },

  {
    "yamatsum/nvim-nonicons",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local icons = require("nvim-nonicons")
      icons.setup()

      require("telescope").setup({
        defaults = {
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
        },
      })
    end,
  },

 --
}
