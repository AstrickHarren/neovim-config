return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			styles = {
				comments = { "italic" },
				functions = { "bold" },
				keywords = { "bold" },
			},
			integrations = { treesitter = true },
			custom_highlights = function(colors)
				return {
					-- ["@lsp.mod.mutable"] = { style = { "bold" } },
					["@function.builtin"] = { link = "Function" },
					["@lsp.typemod.macro"] = { link = "@function.macro" },
					["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.macro" },
					NormalFloat = { bg = colors.none },
					FloatBorder = { fg = colors.overlay0 },
				}
			end,
		},
	},

	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
	},
}
