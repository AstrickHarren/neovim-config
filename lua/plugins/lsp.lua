local function filter_lsp_by_severity()
    -- Create a custom namespace. This will aggregate signs from all other
    -- namespaces and only show the one with the highest severity on a
    -- given line
    local ns = vim.api.nvim_create_namespace("my_namespace")

    -- Get a reference to the original signs handler
    local orig_signs_handler = vim.diagnostic.handlers.signs

    -- Override the built-in signs handler
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            -- Get all diagnostics from the whole buffer rather than just the
            -- diagnostics passed to the handler
            local diagnostics = vim.diagnostic.get(bufnr)

            -- Find the "worst" diagnostic per line
            local max_severity_per_line = {}
            for _, d in pairs(diagnostics) do
                local m = max_severity_per_line[d.lnum]
                if not m or d.severity < m.severity then
                    max_severity_per_line[d.lnum] = d
                end
            end

            -- Pass the filtered diagnostics (with our custom namespace) to
            -- the original handler
            local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end,
    }
end

local on_attach = function(_, _)
    map("n", "[d", function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
    end, { desc = "Go to previous diagnostic" })
    map("n", "]d", function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, { desc = "Go to next diagnostic" })
end

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    ["textDocument/diagnostics"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

return {
    { "williamboman/mason.nvim",           opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "lua_ls" } } },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("neodev").setup({})

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp = require("lspconfig")
            local servers = { "lua_ls", "rust_analyzer", "pest_ls" }

            filter_lsp_by_severity()

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "▎",
                },
            })

            for _, lsp_name in ipairs(servers) do
                lsp[lsp_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    handlers = handlers,
                })
            end
        end,

        keys = {
            { "K",          vim.lsp.buf.hover,          desc = "Hover" },
            { "<c-,>",      vim.lsp.buf.signature_help, desc = "Signature Help" },
            { "<leader>F",  vim.lsp.buf.format,         desc = "Format" },
            -- { "<c-i>", vim.lsp.inlay_hint.enable, desc = "Inlay hints" },

            -- { "gD",         vim.lsp.buf.declaration,    desc = "Go to declaration" },
            -- { "gd",         vim.lsp.buf.definition,     desc = "Go to definition" },
            -- { "gI",         vim.lsp.buf.implementation,  desc = "Go to implementation" },
            -- { "gr",         vim.lsp.buf.references,      desc = "Go to references" },
            -- { "gt",         vim.lsp.buf.type_definition, desc = "Go to type definition" },

            { "<leader>r",  vim.lsp.buf.rename,         desc = "Rename" },
            { "<leader>lm", "<cmd>Mason<cr>",           desc = "Mason" },
            { "<leader>ll", "<cmd>LspInfo<cr>",         desc = "LspInfo" },
            { "<leader>li", "<cmd>Inspect<cr>",         desc = "Inspect token under cursor" },

            { "<c-.>",      vim.lsp.buf.code_action,    desc = "Code action" },
        },
    },
}
