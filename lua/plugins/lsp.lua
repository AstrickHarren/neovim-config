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
    map("n", "Y", function()
        vim.diagnostic.open_float({ border = "rounded" })
    end, { desc = "Show line diagnostics" })
end

local function config_lsps(lsps, capabilities, handlers)
    for _, lsp_cfg in ipairs(lsps) do
        local lsp = require("lspconfig")
        local default_cfg = {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
        }
        local lsp_name = type(lsp_cfg) == "string" and lsp_cfg or lsp_cfg[1]
        local cfg = type(lsp_cfg) == "string" and default_cfg or vim.tbl_extend("force", default_cfg, lsp_cfg)
        lsp[lsp_name].setup(cfg)
    end
end

local function lsp_servers()
    return {
        "lua_ls",
        {
            "rust_analyzer",
            cmd = {
                "rust-analyzer",
            },
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        -- disabled = { "unresolved-proc-macro", "macro-error" },
                    },
                },
            },
        },
        "pest_ls",
        {
            "openscad_lsp",
            cmd = {
                "/home/astrick/.cargo/bin/openscad-lsp",
                "--stdio",
                "--fmt-exe",
                "/opt/clang-format-static/clang-format-17",
            },
        },
    }
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
            require("neodev").setup({
                inlay_hints = { enabled = true },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp = require("lspconfig")
            local servers = lsp_servers()

            filter_lsp_by_severity()

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "▎",
                },
            })
            config_lsps(servers, capabilities, handlers)
        end,

        keys = {
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "<c-,>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = { "n", "v", "i" } },
            { "<leader>F", vim.lsp.buf.format, desc = "Format" },
            -- { "<c-i>", vim.lsp.inlay_hint.enable, desc = "Inlay hints" },

            -- { "gD",         vim.lsp.buf.declaration,    desc = "Go to declaration" },
            -- { "gd",         vim.lsp.buf.definition,     desc = "Go to definition" },
            -- { "gI",         vim.lsp.buf.implementation,  desc = "Go to implementation" },
            -- { "gr",         vim.lsp.buf.references,      desc = "Go to references" },
            -- { "gt",         vim.lsp.buf.type_definition, desc = "Go to type definition" },

            { "<leader>r", vim.lsp.buf.rename, desc = "Rename" },
            { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
            { "<leader>ll", "<cmd>LspInfo<cr>", desc = "LspInfo" },
            { "<leader>li", "<cmd>Inspect<cr>", desc = "Inspect token under cursor" },
            { "<leader>lg", "<cmd>LspInstall<cr>", desc = "Get Lsp for current file" },
            { "<leader>ls", "<cmd>LspStart<cr>", desc = "Start LSP" },
            { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP" },
            { "<leader>lq", "<cmd>LspStop<cr>", desc = "Stop LSP" },

            { "<c-.>", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "i", "v" } },
        },
    },
}
