return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	enabled = false,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		window = { margin = { 1, 0, 1, 0.8 }, border = "single" },
		layout = { height = { min = 4, max = 75 } },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({
			mode = { "n" },
			["<leader>"] = {
				g = { name = "+Git" },
				d = { name = "+Diff" },
				l = { name = "+Lsp" },
			},
		})
	end,
}
