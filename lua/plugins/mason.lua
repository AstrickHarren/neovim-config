return {
  { "williamboman/mason.nvim",           opts = {}, },
  { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "lua_ls" } }, },
  {
    "neovim/nvim-lspconfig",
    config = function()
      lsp = require('lspconfig')
      lsp.lua_ls.setup({})


      map('n', 'K', vim.lsp.buf.hover)
      map('n', '<leader>g', vim.lsp.buf.format)
      map('n', 'gd', vim.lsp.buf.definition)
      map({ 'n', 'v' }, '<c-.>', vim.lsp.buf.code_action)
    end
  }
}
