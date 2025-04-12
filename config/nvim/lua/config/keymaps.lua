-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--[[
vim.keymap.set("n", "<leader>ud", function()
    if not vim.diagnostic.is_enabled() then
        vim.print("Diagnostics are not enabled")
        vim.b.diagnostics_visible = false
        return
    end

    if vim.b.diagnostics_visible == nil then
        vim.b.diagnostics_visible = false
    end

    if vim.b.diagnostics_visible then
        vim.diagnostic.hide(nil, 0)
        vim.print("Diagnostics hidden")
    else
        vim.diagnostic.show(nil, 0)
        vim.print("Diagnostics visible")
    end

    vim.b.diagnostics_visible = not vim.b.diagnostics_visible
end)

]]--
