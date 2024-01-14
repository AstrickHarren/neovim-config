return {
	"lewis6991/gitsigns.nvim",
	opts = {},
	keys = {
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", mode = { "n", "v" } },
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", mode = { "n", "v" } },
		{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>" },
		{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr> " },
		{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr> " },

		{ "]g", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk", mode = { "n", "v" } },
		{ "[g", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk", mode = { "n", "v" } },
	},
	lazy = false,
}
