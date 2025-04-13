return {
  {
    "ibhagwan/smartyank.nvim",
    commit = "0a4554a4ea4cad73dab0a15e559f2128ca03c7b2",
    event = "BufWinEnter",
    config = function()
      require('smartyank').setup{
        highlight = {
          enabled = true,        -- highlight yanked text
          higroup = "IncSearch", -- highlight group of yanked text
          timeout = 500,         -- timeout for clearing the highlight
        },
        clipboard = {
          enabled = true
        },
        tmux = {
          enabled = true, -- remove `-w` to disable copy to host client's clipboard
          cmd = { 'tmux', 'set-buffer', '-w' },
        },
        osc52 = {
          enabled = true,
          escseq = 'tmux', -- use tmux escape sequence, only enable if
                           -- you're using tmux and have issues (see #4)
          ssh_only = true, -- false to OSC52 yank also in local sessions
          silent = false,  -- true to disable the "n chars copied" echo
          echo_hl = "Directory",  -- highlight group of the OSC52 echo message
        },
        validate_yank = false,
      }
      vim.keymap.set({"n", "v"}, "c", "\"_c") -- c doesn't yank the text
      vim.keymap.set({"v"}, "p", "\"_dP") -- p doesn't overwrite copy buffer
    end,
  },
  {
    "gbprod/yanky.nvim",
    commit = "98b9c21d3c06d79f68fd9d471dcc28fc6d2d72ef",
    event = "VeryLazy",
    opts = {},
    -- add keyconfigs https://github.com/gbprod/yanky.nvim
  },
}
