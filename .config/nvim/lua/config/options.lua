vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = { "menu", "menuone", "noselect" }
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
}
opt.winborder = "rounded"

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded" },
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
})
