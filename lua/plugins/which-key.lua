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
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({
			mode = { "n", "v" },
			["<leader>"] = {
				g = { name = "+Git" },
				t = { name = "+Terminal" },
				d = { name = "+Diff" },
				l = { name = "+Lsp" },
				L = { "<cmd>Lazy<cr>", "Lazy" },
				["?"] = { "<cmd>WhichKey<cr>", "Help" },
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
