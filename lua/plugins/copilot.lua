local suggest = true
local view_in_cmp = false

return {
	-- Copilots
	{
		"zbirenbaum/copilot.lua",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = suggest,
				keymap = {
					accept = "<c-f>",
					accept_word = "<c-right>",
					accept_line = "<c-down>",
				},
			},
			panel = {
				enabled = false,
			},
		},
	},

	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua", "yamatsum/nvim-nonicons" },
		lazy = true,
		event = "BufReadPost",
		opts = {},
	},

	{
		"zbirenbaum/copilot-cmp",
		enabled = view_in_cmp,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
