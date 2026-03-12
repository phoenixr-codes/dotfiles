-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "material-lighter" },
  transparency = false,
  hl_override = {
    ["@character"] = { link = "@string" }, -- FIXME: does not work

    -- By default, different colors are applied to different kinds of
    -- keywords. I like keeping all keywords the same color.
    ["@keyword.exception"] = { link = "@keyword" },
    ["@keyword.import"] = { link = "@keyword" },
    ["@keyword.repeat"] = { link = "@keyword" },
    ["@keyword.storage"] = { link = "@keyword" },
    ["@keyword.directive"] = { link = "@keyword" },
  },
}

return M
