vim.opt.termguicolors=false

vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.smartindent=true

vim.opt.scrolloff=8

vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.g.netrw_banner = 0 -- Hide giant banner for netrw

vim.diagnostic.config({
    virtual_text = true,
})
