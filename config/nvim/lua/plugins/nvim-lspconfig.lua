return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        local clangd_cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
        }

        opts.servers.clangd.cmd = clangd_cmd

        return opts
    end,
}
