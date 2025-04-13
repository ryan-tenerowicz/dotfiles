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
    config = function()
      local colors = require("tokyonight.colors")
      require("scrollbar").setup({
        handle = {
            color = colors.bg_highlight,
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
}
