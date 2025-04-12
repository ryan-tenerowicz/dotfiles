return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.3",
    event = "BufReadPre",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "python", "lua", "go", "bash", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        matchup = {
          enable = true,
        },
        incremental_selection = {
          -- Not specific enough, use textsubjects instead
          enable = false,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
      }
    end,
  },
  {
    -- when block is scrolled off screen, definition is show as line at top
    "nvim-treesitter/nvim-treesitter-context",
    commit = "439789a9a8df9639ecd749bb3286b77117024a6f",
    event = "VeryLazy",
    opts = {
      --separator = "━",
    },
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    commit = "abcbb0e537c9c24800b03b9ca33bee5806604629",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require('nvim-treesitter.configs').setup{
        textsubjects = {
          enable = true,
          prev_selection = '<BS>',
          keymaps = {
            ['<CR>'] = 'textsubjects-smart',
          },
        },
      }
    end,
  },
  {
    -- highlight function args in code
    "m-demare/hlargs.nvim",
    commit = "063fa2ba05f5eee5a1ab3da76ecb19770b7725cf",
    event = "VeryLazy",
    config = function()
      require('hlargs').setup{}
    end,
  },
}
