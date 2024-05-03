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

  DiffAdd = { bg = "#003500", fg = "NONE" },
  DiffDelete = { bg = "#400000", fg = "NONE" },
  DiffChange = { bg = "#271344", fg = "NONE" },
  DiffText = { bg = "#434C5E", fg = "NONE" },

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
