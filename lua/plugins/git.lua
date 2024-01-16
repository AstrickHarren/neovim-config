return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
        keys = {
            { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",          mode = { "n", "v" } },
            { "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", mode = { "n", "v" } },
            { "<leader>gb", "<cmd>Gitsigns blame_line<cr>" },
            { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr> " },
            { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr> " },

            { "]g",         "<cmd>Gitsigns next_hunk<cr>",           desc = "Next hunk",     mode = { "n", "v" } },
            { "[g",         "<cmd>Gitsigns prev_hunk<cr>",           desc = "Previous hunk", mode = { "n", "v" } },
        },
        lazy = false,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>",        desc = "Neogit panel",     mode = { "n", "v" } },
            { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit panel", mode = { "n", "v" } },
        },
    },
    {
        "sindrets/diffview.nvim",
        opts = {
            hooks = {
                -- diff_buf_win_enter = function()
                -- 	vim.opt_local.foldenable = false
                -- end,
                --
            },
        },
        keys = {
            {
                "<leader>gd",
                "<cmd>DiffviewOpen<cr>",
                desc = "Open diffview",
            },
            -- { "q", "<cmd>DiffviewClose<cr>", desc = "Close diffview", },
            {
                "<esc>",
                "<cmd>DiffviewClose<cr>",
                desc = "Close diffview",
            },
            {
                "<leader>gH",
                "<cmd>DiffviewFileHistory<cr>",
                desc = "All file history",
            },
            {
                "<leader>gh",
                "<cmd>DiffviewFileHistory %<cr>",
                desc = "Current file history",
            },
        },
    },
}
