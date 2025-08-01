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

------------- LSP
-- Enable completion triggered by <c-x><c-o>
--vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap = true, silent = true, buffer = bufnr }
--vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
--vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
--vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
--vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
--vim.keymap.set("n", "<space>wl", function()
--  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--end, bufopts)
--vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
--vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
--vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
