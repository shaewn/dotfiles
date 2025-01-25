return {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
        "nvim-lua/plenary.nvim", -- For standard functions
        "MunifTanjim/nui.nvim", -- To build the plugin UI
        "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    keys = {
        {
            "<leader>rs",
            "<cmd>RemoteStart<cr>",
            desc = "Start Remote Connection",
        },
        {
            "<leader>rS",
            "<cmd>RemoteStop<cr>",
            desc = "Stop Remote Connection",
        },
        {
            "<leader>ri",
            "<cmd>RemoteInfo<cr>",
            desc = "Info About Current Remote Connection",
        },
        {
            "<leader>rc",
            "<cmd>RemoteCleanup<cr>",
            desc = "Cleanup Remote Config",
        },
        { "<leader>rl", "<cmd>RemoteLog<cr>", desc = "View Remote Log" },
    },
    opts = {
        client_callback = function(port, workspace_config)
            local cmd = ("kitty @ launch --to=$KITTY_LISTEN_ON --type=tab --title='Remote: %s' -- nvim --server localhost:%s --remote-ui"):format(
                workspace_config.host,
                port
            )

            vim.fn.jobstart(cmd, {
                detach = true,
                on_exit = function(job_id, exit_code, event_type)
                    -- This function will be called when the job exits
                    print(
                        "Client",
                        job_id,
                        "exited with code",
                        exit_code,
                        "Event type:",
                        event_type
                    )
                end,
            })
        end,
    },
}
