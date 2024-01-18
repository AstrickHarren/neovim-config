local rainbow = {
	"rainbow1",
	"rainbow2",
	"rainbow3",
	"rainbow4",
	"rainbow5",
	"rainbow6",
	"rainbow7",
}

return {
	{
		"HiPhish/rainbow-delimiters.nvim",
        enabled = false,
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			for _, color in ipairs(rainbow) do
				-- to be set by themes
				vim.api.nvim_set_hl(0, color, { fg = "#ffffff" })
			end

			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = rainbow,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
        enabled = true,
		dependencies = { "HiPhish/rainbow-delimiters.nvim" },
		config = function()
			require("ibl").setup({
				scope = {
					enabled = false,
				},
			})
		end,
	},

	{
		"lukas-reineke/virt-column.nvim",
		opts = { virtcolumn = "80,100", char = "▏" },
	},
}
