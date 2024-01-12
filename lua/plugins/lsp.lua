local on_attach = function(_, _)
	map("n", "[d", function()
		vim.diagnostic.goto_prev({ float = { border = "rounded" } })
	end)
	map("n", "]d", function()
		vim.diagnostic.goto_next({ float = { border = "rounded" } })
	end)
end

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/diagnostics"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

return {
	{ "williamboman/mason.nvim", opts = {} },
	{ "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "lua_ls" } } },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp = require("lspconfig")
			local servers = { "lua_ls", "rust_analyzer", "pest_ls" }

			for _, lsp_name in ipairs(servers) do
				lsp[lsp_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = handlers,
				})
			end
		end,

		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<c-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<leader>F", vim.lsp.buf.format, desc = "Format" },
			-- { "<c-i>", vim.lsp.inlay_hint.enable, desc = "Inlay hints" },

			{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
			-- { "gd",         vim.lsp.buf.definition,     desc = "Go to definition" },
			-- { "gI",         vim.lsp.buf.implementation,  desc = "Go to implementation" },
			-- { "gr",         vim.lsp.buf.references,      desc = "Go to references" },
			-- { "gt",         vim.lsp.buf.type_definition, desc = "Go to type definition" },

			{ "<leader>r", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
			{ "<leader>ll", "<cmd>LspInfo<cr>", desc = "LspInfo" },
			{ "<leader>li", "<cmd>Inspect<cr>", desc = "Inspect token under cursor" },

			{ "<c-.>", vim.lsp.buf.code_action, desc = "Code action" },
		},
	},
}
