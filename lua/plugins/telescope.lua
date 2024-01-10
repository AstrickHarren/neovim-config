return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{ "<leader>f", builtin.find_files, desc = "Find files" },
				{ "<leader>g", builtin.live_grep, desc = "Grep files " },
				{ "<leader>t", builtin.lsp_workspace_symbols, desc = "Symbol picker" },
			}
		end,
		opts = {
			defaults = {
				mappings = {
					i = {
						["<esc>"] = "close",
					},
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			}

			require("telescope").setup({ extensions = extensions })
			require("telescope").load_extension("ui-select")
		end,
	},
}
