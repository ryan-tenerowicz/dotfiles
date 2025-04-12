-- leader must be mapped before plugins so that it is used in their mapping setup
vim.g.mapleader = "\\"
require("user.lazy")
require("user.options")
-- must be loaded after colorscheme plugin so that configuration will have run
vim.cmd("colorscheme tokyonight")
