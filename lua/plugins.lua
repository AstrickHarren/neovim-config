return {
	{ "windwp/nvim-autopairs", opts = {} },
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },

	{ "akinsho/toggleterm.nvim", opts = { start_in_insert = true, persist_mode = false } },

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
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local icons = require("nvim-nonicons")
			icons.setup()

			require("telescope").setup({
				defaults = {
					prompt_prefix = "  " .. icons.get("telescope") .. "  ",
					selection_caret = " ❯ ",
					entry_prefix = "   ",
				},
			})
		end,
	},

	-- noh
	{ "jesseleite/vim-noh" },
}
