-- apt install fd-find ripgrep

local explorer_config = {
  layout = {
    preview = false,
    layout = {
      backdrop = false,
      width = 25,
      min_width = 25,
      height = 0,
      position = "left",
      border = "none",
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = "rounded",
        title = "{title} {live} {flags}",
        title_pos = "center",
      },
      { win = "list", border = "none" },
      { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
  },
  win = {
    input = {
      keys = {
        ["<Esc>"] = { "", mode = { "i", "n", "v" } }, -- prevent ESC from closing the window
        ["<c-f>"] = { "close", mode = { "i", "n", "v" } },
        ["<cr>"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<LeftClick>"] = { {"edit"}, mode = { "i", "n", "v" } },
        ["e"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<c-e>"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<c-s>"] = { "edit_vsplit", mode = { "i", "n", "v" } },
        ["<c-_>"] = { "edit_split", mode = { "i", "n", "v" } },
      }
    },
    list = {
      keys = {
        ["<Esc>"] = { "", mode = { "i", "n", "v" } }, -- prevent ESC from closing the window
        ["<c-f>"] = { "close", mode = { "i", "n", "v" } },
        ["<cr>"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<LeftClick>"] = { {"edit"}, mode = { "i", "n", "v" } },
        ["e"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<c-e>"] = { {"pick_win", "jump"}, mode = { "i", "n", "v" } },
        ["<c-s>"] = { "edit_vsplit", mode = { "i", "n", "v" } },
        ["<c-_>"] = { "edit_split", mode = { "i", "n", "v" } },
      }
    }
  }
}

return {
  {
    "folke/snacks.nvim",
    version = "v2.22.0",
    lazy = false,
    opts = {
      bigfile = {enabled = true},
      bufdelete = {enabled = true},
      scroll = {enabled = true},
      quickfile = {enabled = true},
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i", "n", "v" } }, -- close window with esc instead of going to normal mode
              ["<cr>"] = { {"pick_win", "v", "jump"}, mode = { "i", "n" } },
              ["<c-e>"] = { {"pick_win", "v", "jump"}, mode = { "i", "n" } },
              ["<c-s>"] = { "edit_vsplit", mode = { "i", "n", "v" } },
              ["<c-_>"] = { "edit_split", mode = { "i", "n", "v" } },
              ["<c-l>"] = { "send_to_loclist_vsplit", mode = { "i", "n", "v" } },
            }
          },
        },
        actions = {
          send_to_loclist_vsplit = function(picker)
            picker:close()
            local sel = picker:selected()
            local items = #sel > 0 and sel or picker:items()
            local qf = {} ---@type vim.quickfix.entry[]
            for _, item in ipairs(items) do
              qf[#qf + 1] = {
                filename = Snacks.picker.util.path(item),
                bufnr = item.buf,
                lnum = item.pos and item.pos[1] or 1,
                col = item.pos and item.pos[2] + 1 or 1,
                end_lnum = item.end_pos and item.end_pos[1] or nil,
                end_col = item.end_pos and item.end_pos[2] + 1 or nil,
                text = item.line or item.comment or item.label or item.name or item.detail or item.text,
                pattern = item.search,
                valid = true,
              }
            end
            vim.cmd("vnew")
            vim.fn.setloclist(vim.fn.win_getid(), qf)
            vim.cmd("lopen | lnext | lprev")
          end
        },
      },
    },
    keys = {
      { "<C-p>", function() Snacks.picker.smart() end, desc = "Smart Find Files", mode = { "i", "n", "v" } },
      -- { "<C-p>", function() Snacks.picker.files() end, desc = "Smart Find Files" }, -- files will only search within rootdir which is set in options.lua
      { "<C-f>", function() Snacks.picker.explorer(explorer_config) end, desc = "Snacks File Explorer", mode = { "i", "n", "v" } },
      { "<C-k>", function() Snacks.picker.pick("keymaps", {layout={hidden={"preview"}}}) end, desc = "Keymap Search", mode = { "i", "n", "v" } },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep", mode = { "i", "n", "v" } },

      -- Non picker keymaps
      { "<c-q>", function() Snacks.bufdelete() end, desc = "bufdelete", mode = { "i", "n", "v" } },
      { "<leader>q", function() Snacks.bufdelete() end, desc = "bufdelete", mode = { "i", "n", "v" } },
    },
    config = function(_, opts)
      require("snacks").setup(opts)


      -- Auto open if the window is big enough
      if vim.o.columns > 200 then
        vim.defer_fn(function()
          Snacks.picker.explorer(explorer_config)
        end, 50)
        vim.defer_fn(function()
          vim.cmd("winc l")
        end, 200)
      end
      -- Auto close filetree when it's the last window open
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "snacks_layout_box" and layout[3] == nil then vim.cmd("confirm quit") end
        end
      })
    end
  },
}
