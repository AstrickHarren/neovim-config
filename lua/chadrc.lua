-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "jabuti",

  hl_add = require("highlight").add,
  hl_override = require("highlight").override,
  statusline = require "configs.statusline",
}

return M
