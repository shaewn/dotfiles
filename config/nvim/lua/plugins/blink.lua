return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = {
            preset = "default",
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        sources = {
            default = {
                "lsp",
                "snippets",
                "path",
                "buffer",
            },
        },

        completion = {
            keyword = {
                range = "full",
            },

            documentation = {
                auto_show = false,
                auto_show_delay_ms = 500,
            },

            ghost_text = {
                enabled = false,
            },

            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
        },
    },
}
