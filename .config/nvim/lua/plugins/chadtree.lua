return {
  {
    "ms-jpq/chadtree",
    commit = "257b7290c101cf6fd68e20d72dbb0d4c669738b2",
    enabled = false,
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_var("chadtree_settings", {
        keymap = {
          primary = { "e" },
          v_split = { "s" },
          h_split = { "S" },
        },
        view = {
          width = 30,
        },
      })

      -- Auto open if the window is big enough
      if vim.o.columns > 200 then
        vim.cmd("CHADopen --nofocus") -- nofocus so that cursor stays on main window
      end

      -- Auto close chadtree when it's the last window open
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "CHADTree" and layout[3] == nil then vim.cmd("confirm quit") end
        end
      })
    end,
  },
}
