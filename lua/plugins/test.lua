return {
	{
		"vim-test/vim-test",
		enabled = false,
		keys = {
			{ "<leader>tt", "<cmd>TestFile<cr>", desc = "Test file" },
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last run" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test entire suite" },
			{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test last run in current buffer" },
		},
		opts = {},
		config = function()
			-- local test = require('test')
			-- let test#neovim#term_position = "vert"
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#term_position"] = "vert"
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "antoinemadec/FixCursorHold.nvim",
			"rouge8/neotest-rust",

			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust")({
						args = { "--no-capture" },
					}),
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "neotest-*",
				callback = function(opts)
					vim.keymap.set("n", "q", function()
						vim.api.nvim_win_close(0, true)
					end, { buffer = opts.buf })
				end,
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run({})
				end,
				desc = "Run nearest tests",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run({ suite = true })
				end,
				desc = "Run entire suite",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run last test",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, last_run = true })
				end,
				desc = "Open output",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle summary",
			},
			{
				"<c-t>",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle summary",
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle output panel",
			},
		},
	},
}
