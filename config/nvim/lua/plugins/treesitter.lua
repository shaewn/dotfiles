return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c", "cpp", "bash", "zig", "rust", "swift", "java", "javascript",
      "glsl", "hlsl", "lua", "vim", "vimdoc", "query", "markdown",
      "markdown_inline", "json", "yaml"
    },
    highlight = {
      enable = true,
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
