local augroup = vim.api.nvim_create_augroup("Lspformatting", { clear = true })

return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.rustfmt,
			},

			on_attach = function(_, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end,
		})
	end,
}
