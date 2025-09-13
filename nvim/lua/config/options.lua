vim.g.mapleader = " "

-- cursor
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- columns
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "1"

-- folds
vim.opt.viewoptions:remove("curdir,options")
vim.opt.viewoptions:append("folds")

-- indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = false
vim.opt.breakindent = true

-- chars
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "_" }
vim.opt.fillchars = { eob = " ", lastline = " " }

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- timeout
vim.opt.timeoutlen = 250
vim.opt.updatetime = 250

-- others
vim.opt.wrap = false
vim.opt.mouse = ""
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- auto-session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
