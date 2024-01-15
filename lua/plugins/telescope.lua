return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function()
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            return {
                { "<c-f>",      builtin.find_files,                    desc = "Find files" },
                { "<c-g>",      builtin.live_grep,                     desc = "Find files" },
                { "<leader>ff", builtin.find_files,                    desc = "Find files" },
                { "<leader>fg", builtin.live_grep,                     desc = "Grep files " },
                { "<leader>fs", builtin.lsp_workspace_symbols,         desc = "Workspace symbol picker" },
                { "<leader>ft", builtin.lsp_dynamic_workspace_symbols, desc = "All workspace symbol picker" },
                { "<leader>fo", builtin.treesitter,                    desc = "File symbol picker" },
                { "<leader>fp", builtin.diagnostics,                   desc = "Diagnostics" },
                { "<leader>fj", builtin.jumplist,                      desc = "Jump list" },
                { "<leader>fm", builtin.colorscheme,                   desc = "Colorscheme" },
                { "<leader>fi", builtin.lsp_document_symbols,          desc = "Insane Document symbol picker" },
                { "gd",         builtin.lsp_definitions,               desc = "Go to definitions" },
                { "gr",         builtin.lsp_references,                desc = "Go to references" },
                { "gI",         builtin.lsp_implementations,           desc = "Go to implementations" },
                { "gt",         builtin.lsp_type_definitions,          desc = "Go to type definitions" },
            }
        end,
        opts = {
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = "close",
                        ["<c-cr>"] = "select_vertical",
                        ['<c-j>'] = 'move_selection_next',
                        ['<c-k>'] = 'move_selection_previous',
                    },
                },
                file_ignore_patterns = {
                    "lazy%-lock.json",
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
