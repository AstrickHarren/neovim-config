local rainbows = function(colors)
	local ret = {}
	for i, color in ipairs(colors) do
		ret["rainbow" .. i] = { fg = color }
	end
	return ret
end

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
			integrations = {
				treesitter = true,
				neotree = true,
				neogit = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = {},
						hints = {},
						warnings = {},
						information = {},
					},
					underlines = {
						errors = { "underdouble" },
						warnings = { "underline" },
						information = { "underdashed" },
						hints = { "underdashed" },
					},
					inlay_hints = {
						background = false,
					},
				},
			},
			custom_highlights = function(colors)
				local rainbow_colors = rainbows({
					colors.yellow,
					colors.blue,
					colors.pink,
					colors.sapphire,
					colors.mauve,
					colors.teal,
					colors.peach,
				})

				local U = require("catppuccin.utils.colors")
				local ret = {
					-- ["@lsp.mod.mutable"] = { style = { "bold" } },
					["@function.builtin"] = { link = "Function" },
					["@lsp.typemod.macro"] = { link = "@function.macro" },
					["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.macro" },
					NormalFloat = { bg = colors.none },
					FloatBorder = { fg = colors.overlay0 },
					Folded = {
						fg = colors.overlay2,
						bg = U.vary_color(
							{ latte = U.lighten(C.mantle, 0.70, C.base) },
							U.darken(C.surface0, 0.34, C.base)
						),
					},
					DiffChange = { bg = U.darken(C.yellow, 0.07, C.base) },
					DiffText = { bg = U.darken(C.yellow, 0.30, C.base) },

					-- Subtle parenthesis match highlighting
					MatchParen = { fg = colors.none, bg = colors.none, style = { "underline", "bold" } },

					-- Neotree
					NeoTreeTitleBar = { fg = colors.text },
					NeoTreeDirectoryIcon = { fg = colors.overlay0 },
					NeoTreeDirectoryName = { fg = colors.text },
				}
				return vim.tbl_extend("force", ret, rainbow_colors)
			end,
		},
	},

	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		prirority = 1000,
		opts = {},
	},
}
