return {
  "saghen/blink.cmp",
  version = "1.*",
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

    signature = {
      enabled = true,
      window = {
        show_documentation = false,
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
