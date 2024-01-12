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

		require("neo-tree").setup({
			git_status_async = false, -- TODO: revert this after #724 solved
			filesystem = {
				use_libuv_file_watcher = true,
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
			},
		})
	end,
}
