local modules = {}

modules.mode = function()
  local utils = require "nvchad.stl.utils"
  if not utils.is_activewin() then
    return ""
  end
  local modes = utils.modes
  local m = vim.api.nvim_get_mode().mode
  return "%#St_" .. modes[m][2] .. "Mode# " .. modes[m][1] .. " "
end

modules.diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end
  local icons = require("icons").diagnostic_icons
  local utils = require "nvchad.stl.utils"
  local err = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(utils.stbufnr(), { severity = vim.diagnostic.severity.INFO })
  local e = (err and err > 0) and ("%#St_lspError#" .. icons.Error .. " " .. err .. " ") or ""
  local w = (warn and warn > 0) and ("%#St_lspWarning#" .. icons.Warn .. " " .. warn .. " ") or ""
  local h = (hints and hints > 0) and ("%#St_lspHints#" .. icons.Hint .. " " .. hints .. " ") or ""
  local i = (info and info > 0) and ("%#St_lspInfo#" .. icons.Info .. " " .. info .. " ") or ""
  return " " .. e .. w .. h .. i
end

modules.workspace_diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end
  local icons = require("icons").diagnostic_icons
  local err = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO })
  local e = (err and err > 0) and (icons.Error .. " " .. err .. " ") or ""
  local w = (warn and warn > 0) and (icons.Warn .. " " .. warn .. " ") or ""
  local h = (hints and hints > 0) and (icons.Hint .. " " .. hints .. " ") or ""
  local i = (info and info > 0) and (icons.Info .. " " .. info .. " ") or ""
  return " " .. e .. w .. h .. i
end

modules.cursor = function()
  return "%#St_White# %l:%c "
end

return {
  -- more opts
  order = { "mode", "file", "git", "workspace_diagnostics", "%=", "diagnostics", "cwd", "cursor" },
  theme = "vscode_colored",
  modules = modules,
}
