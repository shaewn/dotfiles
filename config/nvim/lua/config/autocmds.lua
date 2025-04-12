-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Get rid of the annoying auto-commenting when you press enter
-- Or use 'o' or 'O'
vim.api.nvim_create_autocmd("BufNew", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "o", "r" })
    end,
})

--[[
vim.api.nvim_create_autocmd("BufNew", {
    callback = function()
        vim.diagnostic.hide(nil, 0)
    end,
})
]]--
