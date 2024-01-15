return {
	{ "windwp/nvim-autopairs", opts = {} },
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },

	{
		"akinsho/toggleterm.nvim",
		opts = { start_in_insert = true, persist_mode = false, shade_terminals = false },
		keys = {
			{ "<c-j>", "<cmd>ToggleTerm<cr><esc>" },
			{ "<c-j>", "<c-\\><c-n><cmd>ToggleTerm<cr>", mode = { "t" } },
			{ "<c-u>", "<c-\\><c-n><c-u>", mode = { "t" } },

			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>" },
			{ "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>" },
		},
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
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
}
