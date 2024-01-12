return {
	"lewis6991/gitsigns.nvim",
	opts = {},
	keys = {
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>" },
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>" },
		{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>" },
		{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr> " },
		{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr> " },
	},
	lazy = false,
}
