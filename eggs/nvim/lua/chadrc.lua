-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local light_theme = "catppuccin"
local dark_theme = "catppuccin"

M.base46 = {
	theme = dark_theme,
  theme_toggle = { light_theme, dark_theme },
}

return M
