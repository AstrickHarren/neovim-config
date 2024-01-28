return {
	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-nonicons",
		},
		config = function()
			local icons = require("nvim-nonicons")
			local signs = lsp_signs(icons)

			local opts = {
				icons = {
					ERROR = signs.error.icon,
					WARN = signs.warn.icon,
					HINT = signs.hint.icon,
					INFO = signs.info.icon,
				},
				stages = "static",
			}

			require("notify").setup(opts)
		end,
		keys = {
			{ "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notify" },
			{
				"<c-c>",
				function()
					require("notify").dismiss({ silent = true })
				end,
			},
		},
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				format = {
					help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				},
			},
			messages = {
				view = "mini",
				view_search = false,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
