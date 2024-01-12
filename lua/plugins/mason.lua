local on_attach = function(_, _)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
end

return {
  { "williamboman/mason.nvim",           opts = {} },
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
        })
      end
    end,

    keys = {
      { "K",          vim.lsp.buf.hover,           desc = "Hover" },
      { "<c-k>",      vim.lsp.buf.signature_help,  desc = "Signature Help" },
      { "<leader>F",  vim.lsp.buf.format,          desc = "Format" },

      { "gD",         vim.lsp.buf.declaration,     desc = "Go to declaration" },
      { "gd",         vim.lsp.buf.definition,      desc = "Go to definition" },
      { "gI",         vim.lsp.buf.implementation,  desc = "Go to implementation" },
      { "gr",         vim.lsp.buf.references,      desc = "Go to references" },
      { "gt",         vim.lsp.buf.type_definition, desc = "Go to type definition" },

      { "<leader>r",  vim.lsp.buf.rename,          desc = "Rename" },
      { "<leader>lm", "<cmd>Mason<cr>",            desc = "Mason" },
      { "<leader>ll", "<cmd>LspInfo<cr>",          desc = "LspInfo" },

      { "<c-.>",      vim.lsp.buf.code_action,     desc = "Code action" },
    },
  },
}
