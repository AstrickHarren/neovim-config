return {
	"sindrets/diffview.nvim",
	opts = {
		hooks = {
			diff_buf_win_enter = function()
				vim.opt_local.foldenable = false
			end,
		},
	},
	keys = {
		{
			"<leader>dd",
			"<cmd>DiffviewOpen<cr>",
			desc = "Open diffview",
		},
		{
			"q",
			"<cmd>DiffviewClose<cr>",
			desc = "Close diffview",
		},
		{
			"<esc>",
			"<cmd>DiffviewClose<cr>",
			desc = "Close diffview",
		},
		{
			"<leader>dH",
			"<cmd>DiffviewFileHistory<cr>",
			desc = "All file history",
		},
		{
			"<leader>dh",
			"<cmd>DiffviewFileHistory %<cr>",
			desc = "Current file history",
		},
	},
}
