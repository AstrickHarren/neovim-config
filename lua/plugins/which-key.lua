local function toggle_profiling()
	local path = "profile.log"

	if vim.g.profiler_running then
		-- stop profiling
		vim.cmd("profile stop")
		vim.g.profiler_running = false
		print("Profiling write to " .. path)
	else
		-- start profiling
		vim.cmd("profile start " .. path)
		vim.cmd("profile func *")
		vim.cmd("profile file *")
		vim.g.profiler_running = true
		print("Profiling started")
	end
end

local function toggle_expand_tab()
	vim.opt.expandtab = not vim.opt.expandtab:get()
	vim.cmd("%retab!")
end

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		window = { margin = { 1, 0, 1, 0.8 }, border = "single" },
		layout = { height = { min = 4, max = 75 } },
		plugins = {
			presets = {
				windows = false,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		map("n", "<leader>w", "<c-w>")
		wk.register({
			mode = { "n", "v" },
			["<leader>"] = {
				g = { name = "+Git" },
				t = { name = "+Terminal" },
				l = { name = "+Lsp" },
				L = { "<cmd>Lazy<cr>", "Lazy" },
				["?"] = { "<cmd>WhichKey<cr>", "Help" },
				w = {
					name = "+Window",
					s = "Split window",
					v = "Split window vertically",
					q = "Quit a window",
					T = "Break out into a new tab",
					x = "Swap current with next",
					["-"] = "Decrease height",
					["+"] = "Increase height",
					["<lt>"] = "Decrease width",
					[">"] = "Increase width",
					["|"] = "Max out the width",
					["="] = "Equally high and wide",
					h = "Go to the left window",
					l = "Go to the right window",
					k = "Go to the up window",
					j = "Go to the down window",
				},
				d = {
					name = "+Debug",
					p = {
						toggle_profiling,
						"Start profiling",
					},
					m = { "<cmd>messages<cr>", "Messages" },
				},
				[","] = {
					name = "+Preferences",
					w = {
						function()
							vim.opt.list = not vim.opt.list:get()
						end,
						"Toggle whiteSpace visibility",
					},
					t = {
						toggle_expand_tab,
						"Toggle expand tab",
					},
				},
			},

			-- ["<c-w>"] = { "<cmd>x<cr>", "Close window" },
			["<c-w>"] = { close_window_checked_alpha, "Close window" },
			["<M-s>"] = {
				function()
                    vim.lsp.buf.format()
				end,
				"Format",
			},
		})

		wk.register({
			mode = { "n", "x", "o" },
			g = {
				name = "+Goto",
				["*"] = "Search forward under cursor (exprwise)",
				["#"] = "Search backward under cursor (exprwise)",
				h = { "0", "First character of line" },
				s = { "^", "First non-blank character of line" },
				l = { "g_", "Last character of line" },
				e = { "G", "Last non-blank character of line" },
			},
		})
	end,
}
