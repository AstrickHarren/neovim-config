local on_attach = function(_, _)
	map("n", "[d", vim.diagnostic.goto_prev)
	map("n", "]d", vim.diagnostic.goto_next)
end

return {
	{ "williamboman/mason.nvim", opts = {} },
	{ "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "lua_ls" } } },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp = require("lspconfig")
			local servers = { "lua_ls", "rust_analyzer" }

			for _, lsp_name in ipairs(servers) do
				lsp[lsp_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end,

		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<leader>F", vim.lsp.buf.format, desc = "Format" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "<c-.>", vim.lsp.buf.code_action, desc = "Code action" },
		},
	},
}
