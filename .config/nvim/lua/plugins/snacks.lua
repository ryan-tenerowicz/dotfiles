return {
  {
    "folke/snacks.nvim",
    version = "v2.22.0",
    lazy = false,
    opts = {
      bigfile = {enabled = true},
      scroll = {enabled = true},
      quickfile = {enabled = true},
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } }, -- close window with esc instead of going to normal mode
              ["<c-l>"] = { "send_to_loclist_vsplit", mode = { "i", "n" } },
            }
          }
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
        }
      },
    },
    keys = {
      { "<C-p>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      -- { "<C-p>", function() Snacks.picker.files() end, desc = "Smart Find Files" }, -- files will only search within rootdir which is set in options.lua
      { "<C-k>", function() Snacks.picker.pick("keymaps", {layout={hidden={"preview"}}}) end, desc = "Keymaps" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    },
  },
}

