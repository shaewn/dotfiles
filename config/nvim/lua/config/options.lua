-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.g.autoformat = false

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.g.snacks_animate = false

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
