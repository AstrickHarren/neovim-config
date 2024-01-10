return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	},

	{ "windwp/nvim-autopairs", opts = {} },
	{ "github/copilot.vim" },
	{ "tpope/vim-surround" },
	-- { "wellle/targets.vim" },

	{ "akinsho/toggleterm.nvim", opts = {} },

	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
}
