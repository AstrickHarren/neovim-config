return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		window = { margin = { 1, 0, 1, 0.8 }, border = "single" },
		layout = { height = { min = 4, max = 75 } },
		plugins = {
			presets = {
				windows = false,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		map("n", "<leader>w", "<c-w>")
		wk.register({
			mode = { "n", "v" },
			["<leader>"] = {
				g = { name = "+Git" },
				t = { name = "+Terminal" },
				l = { name = "+Lsp" },
				L = { "<cmd>Lazy<cr>", "Lazy" },
				["?"] = { "<cmd>WhichKey<cr>", "Help" },
				w = {
					name = "+Window",
					s = "Split window",
					v = "Split window vertically",
					q = "Quit a window",
					T = "Break out into a new tab",
					x = "Swap current with next",
					["-"] = "Decrease height",
					["+"] = "Increase height",
					["<lt>"] = "Decrease width",
					[">"] = "Increase width",
					["|"] = "Max out the width",
					["="] = "Equally high and wide",
					h = "Go to the left window",
					l = "Go to the right window",
					k = "Go to the up window",
					j = "Go to the down window",
				},
			},

			["<c-w>"] = { "<cmd>x<cr>", "Close window" },
		})

		wk.register({
			mode = { "n", "x", "o" },
			g = {
				name = "+Goto",
				["*"] = "Search forward under cursor (exprwise)",
				["#"] = "Search backward under cursor (exprwise)",
				h = { "0", "First character of line" },
				s = { "^", "First non-blank character of line" },
				l = { "g_", "Last character of line" },
				e = { "G", "Last non-blank character of line" },
			},
		})

		-- wk.register({
		-- 	mode = { "c" },
		-- 	["<c-a>"] = { "<Home>", "Move to start of line" },
		-- 	["<c-b>"] = { "<Left>", "Move left" },
		-- 	["<c-f>"] = { "<Right>", "Move right" },
		-- 	["<c-s>"] = { "<c-f>", "Move right" },
		-- 	["<m-b>"] = { "<S-Left>", "Move left word" },
		-- 	["<m-f>"] = { "<S-Right>", "Move right word" },
		-- })
	end,
}
