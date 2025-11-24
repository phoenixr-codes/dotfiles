return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return {
        override = require "nvchad.icons.devicons",
        override_by_extension = {
          lang = {
            icon = "",
            color = "#74c7ec",
            cterm_color = "25",
            name = "Language",
          },
          ftl = {
            icon = "",
            color = "#74c7ec",
            cterm_color = "25",
            name = "Language",
          },
          mcfunction = {
            icon = "󰍳",
            -- icon = "󰿠",
            color = "#70b237",
            cterm_color = "2",
            name = "Minecraft",
          },
          mcaddon = {
            icon = "󰍳",
            -- icon = "󰿠",
            color = "#70b237",
            cterm_color = "2",
            name = "Minecraft",
          },
          mcpack = {
            icon = "󰍳",
            -- icon = "󰿠",
            color = "#70b237",
            cterm_color = "2",
            name = "Minecraft",
          },
          mcstructure = {
            icon = "󰍳",
            -- icon = "󰿠",
            color = "#70b237",
            cterm_color = "2",
            name = "Minecraft",
          },
        },
      }
    end,
  },

  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },

  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
      { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
      { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" }, desc = "Add or remove cursor" },

      { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
      {
        "<Leader>A",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },

      {
        "<Leader>d",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

      { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- This plugin is already lazy
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },

  {
    "https://github.com/projectfluent/fluent.vim.git",
    lazy = false,
  },

  {
    "https://github.com/windwp/nvim-ts-autotag.git",
    lazy = false, -- This plugin is already lazy
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "amber-lang/amber-vim",
    lazy = false,
  },

  {
    "b0o/schemastore.nvim",
  },

  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").opts {
        sentenceLength = "medium",
        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      }
    end,
    lazy = false,
  },

  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      maxkeys = 5,
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        ATTENTION = {
          icon = "",
          color = "#cba6f7",
        },
        SAFETY = {
          icon = " ",
          color = "hint",
        },
      },
      highlight = {
        keyword = "bg",
      },
    },
  },

  {
    "elkowar/yuck.vim",
  },
}
