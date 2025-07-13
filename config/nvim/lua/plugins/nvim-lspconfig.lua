return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      enabled = false,
    },
    inlay_hints = { enabled = false },
    autoformat = false,
    capabilities = {}, -- TODO: Include these from blink.

    servers = {
      lua_ls = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          format = {
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              quote_style = "none",
              call_arg_parentheses = "remove_table_only",
              max_line_length = "80",
              detect_end_of_line = "true",
              insert_final_newline = "true",
              space_around_table_list = "true",
              align_call_args = "true",
              break_all_list_when_line_exceed = "true",
              end_statement_with_semicolon = "same_line",
            },
          },
        },
      },

      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
        },
        filetypes = {
          "c",
          "cpp",
        },
      },

      gdscript = {
      },

      rust_analyzer = {
      },

      glsl_analyzer = {
      },

      sourcekit = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
        filetypes = {
          "swift",
          "objc",
          "objcpp",
        },
      },
    },
  },
  config = function(_, opts)
    for k, v in pairs(opts.servers) do
      if vim.fn.has('nvim-0.11') then
        vim.lsp.config(k, v)
        vim.lsp.enable(k)
      else
        error("Haven't fixed neovim config for older versions")
      end
    end
  end
}
