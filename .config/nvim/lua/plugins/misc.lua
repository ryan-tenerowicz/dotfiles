return {
  {
    "windwp/nvim-autopairs",
    commit = "2a406cd",
    event = "InsertEnter",
    config = true,
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
  },
  {
    -- rainbow parentheses
    "hiphish/rainbow-delimiters.nvim",
    version = "v0.9.1",
    event = "BufReadPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    -- adds vertical lines for indent to easily tell what level each part is at
    "lukas-reineke/indent-blankline.nvim",
    version = "v3.9.0",
    main = "ibl",
    event = "BufReadPost",
    enabled = true,
    opts = {},
  },
  {
    -- hightlight current line and change number color
    'mawkler/modicator.nvim',
    commit = "45b64561e109cd04de551b081fb947b4f856009e",
    event = "BufReadPre",
    dependencies = 'folke/tokyonight.nvim',
    enabled = true,
    init = function()
      vim.opt.cursorline = true
      vim.opt.number = true
      vim.opt.termguicolors = true
    end,
    config = function()
      require('modicator').setup()
    end,
  },
  {
    -- highlight other uses of word under cursor
    "RRethy/vim-illuminate",
    commit = "19cb21f513fc2b02f0c66be70107741e837516a1",
    event = "VeryLazy",
    enabled = true,
  },
}
