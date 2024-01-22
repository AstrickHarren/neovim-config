return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	keys = { { "<c-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"muniftanjim/nui.nvim",
		"yamatsum/nvim-nonicons",
	},

	lazy = false,

	config = function()
		local icons = require("nvim-nonicons")
		local lsp_signs = lsp_signs(icons)

		require("neo-tree").setup({
			git_status_async = false, -- TODO: revert this after #724 solved
			filesystem = {
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["<c-cr>"] = { "open_vsplit" },
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "",
						deleted = "",
						modified = "",
						renamed = "",

						-- Status type
						untracked = icons.get("unverified"),
						ignored = icons.get("eye-closed"),
						unstaged = icons.get("verified"),
						staged = icons.get("check-circle-fill"),
						conflicted = icons.get("git-merge"),
					},
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				diagnostics = {
					symbols = {
						hint = lsp_signs.hint.icon,
						info = lsp_signs.info.icon,
						warn = lsp_signs.warn.icon,
						error = lsp_signs.error.icon,
					},
					highlights = {
						hint = lsp_signs.hint.hl,
						info = lsp_signs.info.hl,
						warn = lsp_signs.warn.hl,
						error = lsp_signs.error.hl,
					},
				},
			},
		})
	end,
}
