local rainbows = function(colors)
    local ret = {}
    for i, color in ipairs(colors) do
        ret["rainbow" .. i] = { fg = color }
    end
    return ret
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            styles = {
                comments = { "italic" },
                functions = { "bold" },
                keywords = { "bold" },
            },
            integrations = { treesitter = true, neotree = true },
            custom_highlights = function(colors)
                local rainbow_colors = rainbows({
                    colors.yellow,
                    colors.blue,
                    colors.pink,
                    colors.sapphire,
                    colors.mauve,
                    colors.teal,
                    colors.peach,
                })

                local ret = {
                    -- ["@lsp.mod.mutable"] = { style = { "bold" } },
                    ["@function.builtin"] = { link = "Function" },
                    ["@lsp.typemod.macro"] = { link = "@function.macro" },
                    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.macro" },
                    NormalFloat = { bg = colors.none },
                    FloatBorder = { fg = colors.overlay0 },

                    -- Subtle parenthesis match highlighting
                    MatchParen = { fg = colors.none, bg = colors.none, style = { "underline", "bold" } },

                    -- rainbow1 = { fg = colors.yellow },
                    -- rainbow2 = { fg = colors.blue },
                    -- rainbow7 = { fg = colors.pink },
                    -- rainbow4 = { fg = colors.sapphire },
                    -- rainbow5 = { fg = colors.mauve },
                    -- rainbow6 = { fg = colors.teal },
                    -- rainbow3 = { fg = colors.peach },

                    -- Neotree
                    NeoTreeTitleBar = { fg = colors.text },
                    NeoTreeDirectoryIcon = { fg = colors.overlay0 },
                    NeoTreeDirectoryName = { fg = colors.text },
                }
                return vim.tbl_extend("force", ret, rainbow_colors)
            end,
        },
    },

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        enabled = false,
    },
}
