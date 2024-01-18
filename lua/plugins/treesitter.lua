local enabled = true

local text_objs = {
	f = "function",
	a = "parameter",
	n = "conditional",
	l = "loop",
	t = "class",
	-- s = "scope",
}

local keymaps = {}
for key, obj in pairs(text_objs) do
	keymaps["a" .. key] = "@" .. obj .. ".outer"
	keymaps["i" .. key] = "@" .. obj .. ".inner"
end

local move = {
	enable = true,
	set_jumps = true,
	goto_next_start = {
		["]f"] = "@function.outer",
	},
	goto_next_end = {},
	goto_previous_start = {},
	goto_previous_end = {},
}
for key, obj in pairs(text_objs) do
	move.goto_previous_start["[" .. key] = "@" .. obj .. ".outer"
	move.goto_next_start["]" .. key] = "@" .. obj .. ".outer"
	move.goto_previous_end["[" .. key:upper()] = "@" .. obj .. ".outer"
	move.goto_next_end["]" .. key:upper()] = "@" .. obj .. ".outer"
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		enabled = enabled,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "rust" },
				highlight = {
					enable = true,
					disable = { "rust" },
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
		enabled = enabled,
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = keymaps,
					},
					move = move,
				},
				indent = {
					enabled = false,
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
}
