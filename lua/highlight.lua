-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },
  Function = { bold = true },
  ["@comment"] = { link = "Comment" },
  ["@function"] = { link = "Function" },
  ["@function.call"] = { link = "Function" },

  NvimTreeGitDirty = { link = "DiagnosticWarn" },
  NvimTreeGitStagedIcon = { link = "DiagnosticOk" },
  NvimTreeOpenedFolderName = { fg = "#dabcff", bold = true },
  NormalFloat = { bg = "NONE" },

  -- Light theme green: #dafbe1
  -- Light theme red: #ffebe9
  DiffAdd = { bg = "#273732", fg = "NONE" },
  DiffDelete = { bg = "#3F2D32", fg = "NONE" },
  DiffChange = { bg = "one_bg", fg = "NONE" },
  DiffText = { bg = "one_bg3", fg = "NONE" },

  DiagnosticWarn = { fg = "#8B8000" },
  DiagnosticHint = { fg = "#7B68EE" },
}

---@type HLTable
M.add = {
  CmpItemMenu = { link = "Comment" },

  NeogitDiffAdd = { link = "DiffAdd" },
  NeogitDiffDelete = { link = "DiffDelete" },
  NeogitDiffDeleteHighlight = { link = "DiffDelete" },
  DiffviewDiffAddAsDelete = { fg = "NONE", bg = "#400000" },

  DiagnosticInfo = { fg = "#7B68EE" },
  DiagnosticFloatingHint = { fg = "#CF9FFF" },
  DiagnosticFloatingWarn = { fg = "#ebcb8b" },
  DiagnosticFloatingInfo = { fg = "#CF9FFF" },
  qfError = { link = "ErrorMsg" },
}

return M
