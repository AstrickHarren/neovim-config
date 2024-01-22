return {
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },

	{
		"akinsho/toggleterm.nvim",
		opts = { start_in_insert = true, persist_mode = false, shade_terminals = false },
		keys = {
			{ "<c-j>", "<cmd>ToggleTerm<cr><esc>" },
			{ "<c-j>", "<c-\\><c-n><cmd>ToggleTerm<cr>", mode = { "t" } },
			{ "<c-u>", "<c-\\><c-n><c-u>", mode = { "t" } },

			{ "<leader>'f", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
			{ "<leader>'t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Bottom terminal" },
			{ "<leader>'v", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Right terminal" },
		},
	},

	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "<c-/>" },
			opleader = { line = "<c-/>" },
		},
		lazy = false,
		keys = {},
		config = function(_, opts)
			require("Comment").setup(opts)
			local ft = require("Comment.ft")
			ft.set("openscad", "//%s")
		end,
	},

	{
		"yamatsum/nvim-nonicons",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			local icons = require("nvim-nonicons")
			local devicons = require("nvim-web-devicons")
			icons.setup()

			-- Fix lock icon
			devicons.set_icon({ lock = { icon = icons.get("lock"), color = "#5e5e5e", name = "Lock" } })
			devicons.set_icon({ rs = { icon = icons.get("rust"), color = "#6f5242", name = "Rs" } })

			local search = icons.get("search")
			require("telescope").setup({
				defaults = {
					prompt_prefix = "  " .. search .. "  ",
					selection_caret = " ❯ ",
					entry_prefix = "   ",
				},
			})
		end,
	},

	-- noh
	{ "jesseleite/vim-noh" },

	-- dev nvim lua
	{ "folke/neodev.nvim", opts = {}, dependencies = { "nvim-cmp" } },

	-- test
	{
		"vim-test/vim-test",
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
}
