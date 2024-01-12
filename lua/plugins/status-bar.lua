local function copilot()
    return require("copilot_status").status_string()
end

local opts = {
    options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { right = "", left = "" },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
}

local config = function()
    local icons = require("nvim-nonicons")
    local nonicons_extention = require("nvim-nonicons.extentions.lualine")

    opts.sections = {
        lualine_a = {
            {
                "mode",
                fmt = nonicons_extention.mode.fmt,
                padding = { right = 2 },
            },
        },
        lualine_b = {
            {
                "filename",
                symbols = {
                    modified = icons.get("dot-fill"),
                    readonly = icons.get("lock"),
                },
            },
            { "branch", icon = icons.get("git-compare") },
        },
        lualine_c = {
            {
                "diagnostics",
                symbols = {
                    error = icons.get("x-circle") .. " ",
                    info = icons.get("info") .. " ",
                    warn = icons.get("alert") .. " ",
                    hint = icons.get("question") .. " ",
                },
            },
        },

        lualine_x = {
            {
                "diff",
                symbols = {
                    added = icons.get("diff-added") .. " ",
                    modified = icons.get("diff-modified") .. " ",
                    removed = icons.get("diff-removed") .. " ",
                },
            },
        },
        lualine_y = { copilot, { "filetype", icon_only = true }, "progress" },
        lualine_z = {
            { "location" },
        },
    }

    require("lualine").setup(opts)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "yamatsum/nvim-nonicons" },
    config = config,
}
