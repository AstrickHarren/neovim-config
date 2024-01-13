return {
	"akinsho/bufferline.nvim",
	enabled = false,
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
	opts = {
		options = {
			tag = "v2.*",
			offsets = {
				{
					filetype = "neo-tree",
					text = "FILE EXPLORER",
				},
				{
					filetype = "DiffviewFiles",
					text = "SOURCE CONTROL",
					highlight = "Directory",
				},
			},
			separator_style = "slant",
			-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
			always_show_bufferline = false,
		},
	},
	config = function(_, opts)
		vim.opt.termguicolors = true
		require("bufferline").setup(opts)
	end,
}
