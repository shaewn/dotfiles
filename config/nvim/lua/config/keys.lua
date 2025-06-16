---@diagnostic disable: undefined-global
-- Lua evaluation
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Split sizing
vim.keymap.set("n", "<leader>w.", "5<C-w>>")
vim.keymap.set("n", "<leader>w,", "5<C-w><")
vim.keymap.set("n", "<leader>w=", "5<C-w>+")
vim.keymap.set("n", "<leader>w-", "5<C-w>-")

-- Split creation/destruction
vim.keymap.set("n", "<leader>ws", "<C-w>s")
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>wd", "<C-w>c")
vim.keymap.set("n", "<leader>wo", "<C-w>o")

-- Split motion
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<leader>wl", "<C-w>L")
vim.keymap.set("n", "<leader>wh", "<C-w>H")
vim.keymap.set("n", "<leader>wk", "<C-w>K")
vim.keymap.set("n", "<leader>wj", "<C-w>J")

-- Cursor motion
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- Visual selection
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Code Line Diagnostics" })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")

-- Telescope (Basic)
vim.keymap.set("n", "<leader>.", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope builtin<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>t/", "<cmd>Telescope live_grep<CR>")

-- Telescope (LSP)
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>tS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")

-- Telescope (targeted)
vim.keymap.set("n", "<leader>en", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath("config")
  }
end, { desc = "Edit neovim config" })

vim.keymap.set("n", "<leader>ep", function()
  require("telescope.builtin").find_files {
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  }
end, { desc = "Edit plugin files" })

vim.keymap.set("n", "<leader>ec", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.getenv("CODE_DIR")
  }
end, { desc = "Edit code" })

local function print_cwd()
  vim.print(vim.fn.getcwd())
end

local dir_stack = {}         -- stack of previous directories
local popped_dirs_stack = {} -- stack of dirs that we popped

---@param new_dir string
local function pushdir(new_dir)
  local dir = vim.fn.getcwd()
  -- NOTE: This function will error if the directory doesn't exist, and our dir_stack will remain unmodified.
  vim.cmd.cd(new_dir)
  table.insert(dir_stack, dir)
end

local function unpopdir()
  assert(#popped_dirs_stack >= 1, "stack of popped directories empty!")
  local dir = table.remove(popped_dirs_stack, #popped_dirs_stack)
  pushdir(dir)
end

local function popdir()
  assert(#dir_stack >= 1, "directory stack empty!")
  local dir = table.remove(dir_stack, #dir_stack)
  table.insert(popped_dirs_stack, dir)
  vim.cmd.cd(dir)
end

local function dirfn(func)
  return function()
    func()
    print_cwd()
  end
end

-- Directories
vim.keymap.set("n", "<leader>df", dirfn(
  function() pushdir(vim.fn.expand("%:h")) end
), { desc = "cd %:h" })

vim.keymap.set("n", "<leader>d-", dirfn(
  function() popdir() end
), { desc = "goto previous directory" })

vim.keymap.set("n", "<leader>dt", dirfn(
  function()
    local dir = vim.fn.input("Go to directory: ", "", "dir")
    pushdir(dir)
  end
), { desc = "goto named directory" })

vim.keymap.set("n", "<leader>d..", dirfn(
  function()
    pushdir("..")
  end
), { desc = "goto parent directory" })

vim.keymap.set("n", "<leader>d+", dirfn(
  function() unpopdir() end
), { desc = "`undo'" })

vim.keymap.set("n", "<leader>dc", function()
  dir_stack = {}
  print("Directory stack cleared!")
end, { desc = "clear the directory stack" })

-- Print
vim.keymap.set("n", "<leader>pwd", dirfn(
  function() end
), { desc = "pwd" })

vim.keymap.set("n", "<leader>pds", function()
  vim.print(dir_stack)
end, { desc = "print directory stack" })

vim.keymap.set("n", "<leader>pps", function()
  vim.print(popped_dirs_stack)
end, { desc = "print popped dirs stack" })

-- UI
vim.keymap.set("n", "<leader>ut", function()
  MiniFiles.open()
end, { desc = "open file tree (mini.files)" })
