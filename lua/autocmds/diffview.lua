local function hl(theme)
  return {
    DiffAdd = { bg = theme == "dark" and "#273732" or "#dafbe1", fg = "NONE" },
    DiffDelete = { bg = theme == "dark" and "#3F2D32" or "#ffebe9", fg = "NONE" },
  }
end

local callback = function()
  local theme = require("base46").get_theme_tb "type"
  local load_hls = require("utils.loading").load_hls
  load_hls(hl(theme))
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "diffview:///*",
  callback = callback,
})
