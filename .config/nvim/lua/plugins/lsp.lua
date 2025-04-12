return {
  {
    'saghen/blink.cmp',
    version = "v1.1.1",
    build = 'cargo build --release',
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    'neovim/nvim-lspconfig',
    version = "v1.8.0",
    lazy = false,
    dependencies = { 'saghen/blink.cmp' },
    opts = {
      servers = {
        lua_ls = {},
        go_ls = {},
        python_ls = {},
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.keymap.set('n', '<F1>', function()
        vim.lsp.buf.format { async = true }
      end)
    end,
  },
  {
    "rafaelsq/nvim-goc.lua",
    commit = "9fbd6e72b2510da22365879557b927408a885619",
    event = "VeryLazy",
    config = function()
      local goc = require('nvim-goc')
      goc.setup({ verticalSplit = true })
      vim.keymap.set('n', '<Leader>cc', goc.Coverage, {silent=true, noremap=true})       -- run for the whole File
      vim.keymap.set('n', '<Leader>cf', goc.ClearCoverage, {silent=true, noremap=true})  -- clear coverage highlights
    end,
  },
}
