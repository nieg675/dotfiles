-- Basic Settings
vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  nbsp = "␣",
  trail = "·",
  space = "·",
  extends = "⟩",
  precedes = "⟨",
}
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = "number"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
-- Consider
-- vim.opt.laststatus = 3

vim.opt.syntax = "on"

-- Diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { noremap = true, silent = true }
)
-- NOTE: Once the jump options is released, we can remove the above remap
-- vim.diagnostic.config {
--   jump = { float = true },
-- }

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = false })

vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { noremap = true, silent = true }
)

--Plugins

--Papercolor theme
vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd.colorscheme "PaperColor"

--Telescope
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--hidden",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--glob",
      "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}",
    },
    layout_strategy = "vertical",
    wrap_results = true,
    sorting_strategy = "ascending",
    layout_config = {
      vertical = {
        width = 0.99,
        height = 0.99,
      },
    },
  },
  pickers = {
    oldfiles = {
      initial_mode = "normal",
    },
    find_files = {
      find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
    },
  },
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}

vim.keymap.set(
  "n",
  "<leader>ft",
  require("telescope.builtin").find_files,
  { noremap = true }
)

vim.keymap.set("n", "<leader>fe", function()
  require("telescope.builtin").find_files { cwd = "~/repos" }
end, { noremap = true })

vim.keymap.set("n", "<leader>fr", function()
  local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require("telescope.builtin").find_files { cwd = repo_root }
end, { noremap = true })

vim.keymap.set(
  "n",
  "<leader>fg",
  require("telescope.builtin").live_grep,
  { noremap = true }
)

vim.keymap.set("n", "<leader>fd", function()
  require("telescope.builtin").live_grep { cwd = "~/repos" }
end, { noremap = true })

vim.keymap.set("n", "<leader>ff", function()
  local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require("telescope.builtin").live_grep { cwd = repo_root }
end, { noremap = true })

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

require'lspconfig'.elixirls.setup {
    cmd = { 'elixir-ls' }
}
