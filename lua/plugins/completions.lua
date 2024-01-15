return {
	{
		"hrsh7th/cmp-nvim-lsp",
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"onsails/lspkind-nvim",
		init = function()
			local lspkind = require("lspkind")
			lspkind.init({
				preset = "codicons",
				symbol_map = {
					Text = "",
					Copilot = "",
					Field = "󰓼",
					Method = "",
					Functon = "󰍘",
					Module = "",
					EnumMember = "󰈍",
					Keyword = "",
					Constant = "π",
					-- Constant = '',
					Value = "󰎠",
					-- Value = '󰎥',
				},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = { "onsails/lspkind-nvim" },
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				enabled = true,
				view = { name = "custom", selection_order = "near_cursor" },
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local opts = {
							mode = "symbol",
							maxwidth = 50,
							max_menu_width = 10,
							-- menu = { buffer = "[BUF]", nvim_lsp = "[LSP]", },
							ellipsis_char = "..",
						}
						local item = lspkind.cmp_format(opts)(entry, vim_item)

						vim_item.kind = item.kind .. " "
						if vim.fn.strchars(vim_item.menu) > opts.max_menu_width then
							vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, opts.max_menu_width - 1)
								.. opts.ellipsis_char
						end

						item.menu_hl_group = "Comment"
						return item
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				performance = {
					-- max_view_entries = 5,
				},

				experimental = {
					ghost_text = true,
				},

				preselect = cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					-- ["<cr>"] = cmp.mapping.confirm(),
					["<tab>"] = cmp.mapping.confirm({ select = true }),
					-- ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					-- ["<s-tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
				sorting = { priority = 10 },
				sources = cmp.config.sources({
					{ name = "copilot", priority = 2, max_item_count = 1 },
					{ name = "nvim_lsp", priority = 10 },
					-- { name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
