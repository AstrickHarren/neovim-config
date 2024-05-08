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

  DiffChange = { bg = "one_bg", fg = "NONE" },
  DiffText = { bg = "one_bg3", fg = "NONE" },
}

---@type HLTable
M.add = {
  CmpItemMenu = { link = "Comment" },

  NeogitDiffAdd = { link = "DiffAdd" },
  NeogitDiffDelete = { link = "DiffDelete" },
  NeogitDiffDeleteHighlight = { link = "DiffDelete" },
  DiffviewDiffAddAsDelete = { fg = "NONE", bg = "#400000" },

  qfError = { link = "ErrorMsg" },
}

return M
