return {
  "Wansmer/treesj",
  keys = {
    { "<leader>m", "<cmd>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
  },
  cmds = { "TSJToggle", "TSJSplit", "TSJJoin" },
  opts = {
    use_default_key_maps = false,
  },
}
