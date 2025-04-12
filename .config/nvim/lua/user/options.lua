vim.opt.backspace = {"indent", "eol", "start"} -- normal backspace behavior
vim.keymap.set({'n', 'i', 'v'}, '<MiddleMouse>', '<Nop>', {silent = true})
vim.opt.number = true -- show line number
vim.opt.mouse = "a" -- allow mouse clicks
vim.opt.virtualedit = "onemore" -- allow cursor to move past end of line onto newline char
vim.opt.cmdheight = 0 -- hides command prompt when not writing a command with :
--vim.opt.scrolloff = 10 -- keep cursor 10 lines from bottom of screen
vim.opt.ttimeout = true -- enable custom timeout for multi char commands
vim.opt.ttimeoutlen = 50 -- custom timeout length
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.linebreak = true -- companion to wrap, don't split words
vim.opt.fillchars = "vert:█"
-- Default Tab settings
vim.bo.autoindent = true -- auto indent newline to same indent
vim.bo.tabstop = 2 -- set tab to 2 columns
vim.bo.shiftwidth = 2 -- set width for autoident
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true
-- Search settings
vim.opt.hlsearch = true -- highlight search
vim.opt.incsearch = true -- incremental search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- uses case if search includes uppercase letters
vim.opt.iskeyword:append "-" -- hyphenated words recognized by searches
vim.keymap.set({'n', 'i', 'v'}, '<F2>', ':nohl<CR>', {silent = true})
-- Temp file settings
os.execute('mkdir -p /var/tmp/nvim/swp')
vim.opt.directory = "/var/tmp/nvim/swp"
vim.opt.updatetime = 1000 --save swap if nothing typed in 1 seconds
os.execute('mkdir -p /var/tmp/nvim/undo')
vim.opt.undodir = "/var/tmp/nvim/undo/"
vim.opt.undofile = true
os.execute('mkdir -p /var/tmp/nvim/backup')
vim.opt.backupdir = "/var/tmp/nvim/backup"
vim.opt.backup = true -- write backups when overwriting file

--remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[silent! %s/\s\+$//e]],
})
vim.keymap.set({"n"}, "o", "ox<BS>")
vim.keymap.set({"n"}, "O", "Ox<BS>")

vim.cmd[[
augroup FileTypeSettings
  autocmd!
  autocmd BufEnter * lua if vim.bo.filetype == 'python' then PythonSettings() end
  autocmd BufEnter * lua if vim.bo.filetype == 'lua' then LuaSettings() end
augroup END
]]

function PythonSettings()
  vim.bo.autoindent = true -- auto indent newline to same indent
  vim.bo.tabstop = 2 -- set tab to 2 columns
  vim.bo.shiftwidth = 2 -- set width for autoident
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = [[silent! %s/\t/  /g]],
  })
end

function LuaSettings()
  vim.bo.autoindent = true -- auto indent newline to same indent
  vim.bo.tabstop = 2 -- set tab to 2 columns
  vim.bo.shiftwidth = 2 -- set width for autoident
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = [[silent! %s/\t/  /g]],
  })
end


-- Automatically find && change root directory based on filenames
-- Array of file names indicating root directory.
local root_names = { '.git', 'lua'}

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('AutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })



-- automatically close location list when closing window
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function(args)
    vim.cmd("lclose")
  end,
})
