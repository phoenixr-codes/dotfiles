require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "i", "v" }, "<C-z>", "<cmd> undo <cr>", { desc = "Undo" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)

  local additional_buttons = { name = "Rename symbol", cmd = require("nvchad.lsp.renamer"), rtxt = "<leader>ra" }
  local options = vim.bo[buf].ft == "NvimTree" and require("menus.nvimtree") or { additional_buttons, unpack(require("menus.default")) }

  require("menu").open(options, { mouse = true })
end, {})
