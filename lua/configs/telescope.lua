local opts = require "nvchad.configs.telescope"

opts.defaults.mappings = {
  i = {
    ["<esc>"] = "close",
    ["<c-cr>"] = "select_vertical",
    ["<c-j>"] = "move_selection_next",
    ["<c-k>"] = "move_selection_previous",
    ["<c-h>"] = "which_key",
  },
}

opts.defaults.path_display = function(_, path)
  local tail = require("telescope.utils").path_tail(path)
  local base = tail == path and "" or "(" .. path:sub(1, #path - #tail - 1) .. "/)"
  return string.format("%s %s", tail, base)
end

dofile(vim.g.base46_cache .. "telescope")
local telescope = require "telescope"
telescope.setup(opts)
-- load extensions
for _, ext in ipairs(opts.extensions_list) do
  telescope.load_extension(ext)
end
