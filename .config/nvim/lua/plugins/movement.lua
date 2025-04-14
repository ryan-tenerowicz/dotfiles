return {
  {
    "sphamba/smear-cursor.nvim",
    version = "v0.4.5",
    event = "VeryLazy",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,

      min_horizontal_distance_smear = 3,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    commit = "6994eb9f73d5fdc36ee2c8717940e8c853e51a49",
    event = "VeryLazy",
    enabled = false,
    config = function()
      local colors = require("tokyonight.colors")
      require("scrollbar").setup({
        hide_if_all_visible = true,
        handle = {
          color = "#445588",
        },
        marks = {
            Search = { color = colors.orange },
            Error = { color = colors.error },
            Warn = { color = colors.warning },
            Info = { color = colors.info },
            Hint = { color = colors.hint },
            Misc = { color = colors.purple },
        }
      })
    end,
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    enabled = true,
    config = function()
      require('scrollview').setup({
        current_only = true,
      })
    end,
  },
  {
    "echasnovski/mini.map",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require('mini.map').setup({
        window = {
          focusable = true,
        },
      })
      MiniMap.open()
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup({
        auto_enable = true,
        minimap_width = 5,
      })
      codewindow.apply_default_keybinds()
    end,
  }
}
