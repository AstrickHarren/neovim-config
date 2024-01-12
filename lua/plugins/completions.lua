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
				symbol_map = {
					Text = "",
					Copilot = " ",
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
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 80,
						ellipsis_char = "...",
					}),
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

				preselect = cmp.PreselectMode.None,

				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.scroll_docs(4),
					["<C-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<s-tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
