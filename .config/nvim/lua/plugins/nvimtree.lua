return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "v1.11.0",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({
        update_focused_file = {
          enable = true,
          update_root = {
            enable = true,
          },
        },
        sort_by = "case_sensitive",
        filters = {
          dotfiles = true,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return {
              desc = 'nvim-tree: ' .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', 'e', api.node.open.edit, opts('Open: Edit'))
          vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
        end
      })
    end,
  },
  {
    'mikew/nvim-drawer',
    commit = "2b1db633d9eca134502e1753e5a38974ba309fe1",
    event = "BufReadPost",
    enabled = false,
    opts = {},
    config = function(_, opts)
      local drawer = require('nvim-drawer')
      drawer.setup(opts)

      drawer.create_drawer({
        -- This is needed for nvim-tree.
        nvim_tree_hack = true,

        position = 'left',
        size = 25,

        on_vim_enter = function(event)
          --- Open the drawer on startup.
          event.instance.open({
            focus = false,
          })

          --- Example mapping to toggle.
          vim.keymap.set('n', '<leader>e', function()
            event.instance.focus_or_toggle()
          end)
        end,

        --- Ideally, we would just call this here and be done with it, but
        --- mappings in nvim-tree don't seem to apply when re-using a buffer in
        --- a new tab / window.
        on_did_create_buffer = function()
          local nvim_tree_api = require('nvim-tree.api')
          nvim_tree_api.tree.open({ current_window = true })
          nvim_tree_api.tree.reload()
        end,

        --- This gets the tree to sync when changing tabs.
        on_did_open = function()
          local nvim_tree_api = require('nvim-tree.api')
          nvim_tree_api.tree.reload()

          vim.opt_local.number = false
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.statuscolumn = ''
        end,

        --- Cleans up some things when closing the drawer.
        on_did_close = function()
          local nvim_tree_api = require('nvim-tree.api')
          nvim_tree_api.tree.close()
        end,
      })
    end
  },
}
