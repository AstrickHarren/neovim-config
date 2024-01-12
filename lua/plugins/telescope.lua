return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>f", builtin.find_files,                    desc = "Find files" },
        { "<leader>s", builtin.live_grep,                     desc = "Grep files " },
        { "<leader>t", builtin.lsp_workspace_symbols,         desc = "Workspace symbol picker" },
        { "<leader>T", builtin.lsp_dynamic_workspace_symbols, desc = "All workspace symbol picker" },
        { "<leader>o", builtin.treesitter,                    desc = "File symbol picker" },
        { "<leader>P", builtin.diagnostics,                   desc = "Diagnostics" },
        { "gd",        builtin.lsp_definitions,               desc = "Go to definitions" },
        { "gr",        builtin.lsp_references,                desc = "Go to references" },
        { "gI",        builtin.lsp_implementations,           desc = "Go to implementations" },
        { "gt",        builtin.lsp_type_definitions,          desc = "Go to type definitions" },
      }
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = "close",
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      }

      require("telescope").setup({ extensions = extensions })
      require("telescope").load_extension("ui-select")
    end,
  },
}
