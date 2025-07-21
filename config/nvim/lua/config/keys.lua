---@diagnostic disable: undefined-global
-- Lua evaluation
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

--Writing and quitting
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Soft quit" })
vim.keymap.set("n", "<leader>qf", ":qa<CR>", { desc = "Hard/force quit" })
vim.keymap.set("n", "<leader>wqq", ":wqa<CR>", { desc = "Write all then quit (no bang)" })
vim.keymap.set("n", "<leader>wqq", ":wqa!<CR>", { desc = "Write all then quit (with bang)" })
vim.keymap.set("n", "<leader>wa", ":wa<CR>", { desc = "Write all" })

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

function telescope_buffers()
    require("telescope.builtin").buffers({
      sort_mru = true,
    })
end

-- Buffer keys
vim.keymap.set("n", "<leader>bd", ":bd<CR>")
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "buffer equivalent of <leader>wo" })
vim.keymap.set("n", "<leader>,", telescope_buffers, { desc = "Telescope buffers" })

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
vim.keymap.set("n", "<leader>tB", "<cmd>Telescope builtin<CR>")
vim.keymap.set("n", "<leader>t,", telescope_buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>tm", "<cmd>Telescope man_pages<CR>")
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

---@type string[]
local dir_stack = {}         -- stack of previous directories
---@type string[]
local from_dir_stack = {} -- stack of dirs that we popped

---@param new_dir string
local function pushdir(new_dir)
  local dir = vim.fn.getcwd()

  if pcall(vim.cmd.cd, new_dir) then
    table.insert(dir_stack, dir)
    return true
  else
    print("Failed to change to directory", new_dir)
    return false
  end
end

---@param pop_from string[]
---@param push_to string[]
local function dirpop(pop_from, push_to)
  if #pop_from < 1 then
    print("stack empty!")
    return false
  end

  local dir = table.remove(pop_from, #pop_from)
  local cwd = vim.fn.getcwd()
  vim.cmd.cd(dir)
  table.insert(push_to, cwd)
  return true
end

local function unpopdir()
  return dirpop(from_dir_stack, dir_stack)
end

local function popdir()
  return dirpop(dir_stack, from_dir_stack)
end

local function dirfn(func)
  return function()
    local rv = func()

    if rv == nil or rv then
      print_cwd()
    end
  end
end

-- Directories
vim.keymap.set("n", "<leader>df", dirfn(
  function() return pushdir(vim.fn.expand("%:h")) end
), { desc = "cd %:h" })

vim.keymap.set("n", "<leader>d-", dirfn(
  function() return popdir() end
), { desc = "popdir" })

vim.keymap.set("n", "<leader>d+", dirfn(
  function() return unpopdir() end
), { desc = "undo popdir" })

vim.keymap.set("n", "<leader>dt", dirfn(
  function()
    local dir = vim.fn.input("Go to directory: ", "", "dir")
    return pushdir(dir)
  end
), { desc = "goto named directory" })

vim.keymap.set("n", "<leader>dH", dirfn(
  function()
    local homedir = vim.env.HOME
    return pushdir(homedir)
  end
), { desc = "Enter user home directory" })

vim.keymap.set("n", "<leader>dC", dirfn(
  function()
    local confdir = vim.fn.stdpath("config")
    return pushdir(confdir)
  end
), { desc = "Enter user neovim config" })

vim.keymap.set("n", "<leader>d..", dirfn(
  function()
    pushdir("..")
  end
), { desc = "goto parent directory" })

vim.keymap.set("n", "<leader>dcd", function()
  dir_stack = {}
  print("Directory stack cleared!")
end, { desc = "clear the directory stack" })

vim.keymap.set("n", "<leader>dcf", function()
  from_dir_stack = {}
  print("Directory from stack cleared!")
end, { desc = "clear the directory from stack" })

-- Print
vim.keymap.set("n", "<leader>pwd", dirfn(
  function() end
), { desc = "pwd" })

vim.keymap.set("n", "<leader>pds", function()
  vim.print(dir_stack)
end, { desc = "print directory stack" })

vim.keymap.set("n", "<leader>pfs", function()
  vim.print(from_dir_stack)
end, { desc = "print popped dirs stack" })

vim.keymap.set("n", "<leader>pfd", function()
  vim.print(vim.fn.expand("%:h"))
end, { desc = "print the parent directory of the current file" })

-- UI
local function mini_files()
  MiniFiles.open()
end

vim.keymap.set("n", "<leader>ut", mini_files, { desc = "open file tree (mini.files)" })
vim.keymap.set("n", "-", mini_files, { desc = "open file tree (mini.files)" })
