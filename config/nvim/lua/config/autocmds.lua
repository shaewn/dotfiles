---@diagnostic disable: undefined-global
-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function(_)
    vim.hl.on_yank()
  end
})

-- Lsp stuff
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client_id = ev.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local caps = client.server_capabilities

    local bufopts = { buffer = true }

    ---@param desc string
    ---@return table<any>
    local function tbl(desc)
      if not desc then
        return bufopts
      end

      new_table = {}

      for k, v in pairs(bufopts) do
        new_table[k] = v
      end

      new_table.desc = desc
      return new_table
    end

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, tbl("Code Action"))
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, tbl("Code Format"))
    vim.keymap.set("v", "<leader>cf", vim.lsp.buf.format, tbl("Code Format (Selection)"))
    vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions() end, tbl("Goto Definition"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, tbl("Goto Declaration"))
    vim.keymap.set("n", "gy", function() require("telescope.builtin").lsp_type_definitions() end, tbl("Goto Type Definition"))
    vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, tbl("Goto References"))
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, tbl("Code Rename"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, tbl("Hover"))
    -- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, tbl("Signature Help"))
    vim.keymap.set("n", "<leader>cs", vim.lsp.buf.document_symbol, tbl("Code Symbols"))
    vim.keymap.set("n", "<leader>cS", vim.lsp.buf.workspace_symbol, tbl("Code Workspace Symbols"))
    vim.keymap.set("n", "<leader>uh",
      function()
        enabled = not vim.lsp.inlay_hint.is_enabled()
        vim.lsp.inlay_hint.enable(enabled)
        vim.notify("Inlay Hints have been " .. (enabled and "enabled" or "disabled"))
      end, tbl("UI Toggle Inlay Hints"))

    if client.name == "clangd" and (vim.bo.filetype == "cpp" or vim.bo.filetype == "c") then
      vim.keymap.set("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<CR>")
    end
  end
})

-- Annoying comment behavior
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    vim.opt.formatoptions:remove('o')
    vim.opt.formatoptions:remove('r')
  end
})
