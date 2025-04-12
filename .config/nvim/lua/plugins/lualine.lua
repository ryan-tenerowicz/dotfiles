return {
  {
    -- Requires patched nerd font
    "nvim-lualine/lualine.nvim",
    commit = "0ea56f91b7f51a37b749c050a5e5dfdd56b302b3",
    event = "VimEnter",
    dependencies = {
      "linrongbin16/lsp-progress.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require('lualine').setup{
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          always_divide_middle = false, -- allow one side to go past the middle
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'filename'},
          lualine_c = {
            {
              function()
                return require("lsp_signature").status_line(200).label
              end,
            },
          },
          lualine_x = {},
          lualine_y = {
            {
              function()
                return require('lsp-progress').progress()
              end,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn" },
              symbols = { error = "⛔", warn = "⚠" },
              colored = true,
              always_visible = true,
            },
          },
          lualine_z = {'location'},
        },
      }

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },
  {
    -- alternate lsp status above lualine
    "j-hui/fidget.nvim",
    tag = "legacy",
    enabled = false,
    event = "LspAttach",
    opts = {},
  },
  {
    -- added / removed lines in a file
    "lewis6991/gitsigns.nvim",
    version = "v1.0.2",
    event = "VeryLazy",
    opts = {
      numhl = true, -- highlight the number column as well
    },
  },
}
