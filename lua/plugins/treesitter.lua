return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		keys = { { "<c-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "rust" },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		depends = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["as"] = "@scope.outer",
							["is"] = "@scope.inner",
							["at"] = "@conditional.outer",
							["it"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},

					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.outer",
							["]t"] = "@conditional.outer",
							["]s"] = "@scope.outer",
							["]l"] = "@loop.outer",
						},

						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.outer",
							["]T"] = "@conditional.outer",
							["]S"] = "@scope.outer",
							["]L"] = "@loop.outer",
						},

						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.outer",
							["[t"] = "@conditional.outer",
							["[s"] = "@scope.outer",
							["[l"] = "@loop.outer",
						},

						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.outer",
							["[T"] = "@conditional.outer",
							["[S"] = "@scope.outer",
							["[L"] = "@loop.outer",
						},
					},
				},
			})

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
		end,
	},

	{
		"kiyoon/treesitter-indent-object.nvim",
		keys = {
			{
				"ai",
				function()
					require("treesitter_indent_object.textobj").select_indent_outer()
				end,
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer)",
			},
			{
				"aI",
				function()
					require("treesitter_indent_object.textobj").select_indent_outer(true)
				end,
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer, line-wise)",
			},
			{
				"ii",
				function()
					require("treesitter_indent_object.textobj").select_indent_inner()
				end,
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, partial range)",
			},
			{
				"iI",
				function()
					require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
				end,
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
			},
		},
	},
}
