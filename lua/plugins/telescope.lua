return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local opts = {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = "close"
            }
          }
        }
      }
      require('telescope').setup(opts)
      local bulitin = require('telescope.builtin')
      map('n', '<leader>f', bulitin.find_files)
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      local extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      }

      require('telescope').setup({ extensions = extensions })
      require('telescope').load_extension('ui-select')
    end
  }
}
