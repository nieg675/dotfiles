require "nhe.packer"(function(use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "mhartington/formatter.nvim"
  use 'NLKNguyen/papercolor-theme'
  use 'mhinz/vim-grepper'
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use 'ekalinin/Dockerfile.vim'
  use 'junegunn/fzf.vim'
  use 'https://github.com/tpope/vim-fugitive'
  -- use 'https://github.com/romainl/vim-cool'
  use 'elixir-editors/vim-elixir'
  use "lewis6991/gitsigns.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "sindrets/diffview.nvim"
  use 'nvim-tree/nvim-web-devicons'
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",        -- Optional
        "nvim-telescope/telescope.nvim" -- Optional
    }
}
end)

local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    --completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    --{ name = 'vsnip' }, -- For vsnip users.
    { name = "luasnip" }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = "buffer" },
  }),
}

-- Basic Settings
vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  nbsp = "␣",
  trail = "·",
  -- Cursor disappears with nord
  --space = "·",
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
vim.opt.smartindent = true
--vim.opt.clipboard = "unnamedplus"
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = "number"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest", "list" }
vim.opt.background = "light"
vim.cmd [[colorscheme PaperColor]]

--require("gitsigns").setup()
require("mason").setup()
-- prettier, stylua manually
require("mason-lspconfig").setup {
  automatic_installation = true,
}

--vim.keymap.set(
--  "n",
--  ":",
--  ";",
--  { noremap = true, silent = false }
--)
--
--vim.keymap.set(
--  "n",
--  ";",
--  ":",
--  { noremap = true, silent = false }
--)

--vim.keymap.set(
--  "n",
--  "F",
--  "?",
--  { noremap = true, silent = false }
--)
--
--vim.keymap.set(
--  "n",
--  "f",
--  "/",
--  { noremap = true, silent = false }
--)
--
--vim.keymap.set(
--  "n",
--  "dF",
--  "d?",
--  { noremap = true, silent = false }
--)
--
--vim.keymap.set(
--  "n",
--  "df",
--  "d/",
--  { noremap = true, silent = false }
--)

--vim.keymap.set(
--  "n",
--  "cF",
--  "c?",
--  { noremap = true, silent = false }
--)

--vim.keymap.set(
--  "n",
--  "cf",
--  "c/",
--  { noremap = true, silent = false }
--)
vim.keymap.set('t', 'jk',     '<C-\\><C-N>', { silent = true } )

vim.keymap.set(
  "n",
  "<leader>t",
  ":tabnext<CR>",
  { noremap = true, silent = false }
)
vim.keymap.set(
  "i",
  "jk",
  "<Esc>",
  { noremap = true, silent = false }
)

vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>r",
  ":Telescope resume<CR>",
  { noremap = true, silent = true }
)

local navbuddy = require("nvim-navbuddy")

local on_attach = function(client, bufnr)
  navbuddy.attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set("n", "<space>wl", function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  --vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

require("lspconfig").rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").elixirls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
--require("lspconfig").yamlls.setup {
--  on_attach = on_attach,
--  capabilities = capabilities,
--}

require("formatter").setup {
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },
    elixir = {
      require("formatter.filetypes.elixir").mixformat,
    },
    yaml = {
      require("formatter.filetypes.yaml").prettier,
    },
    markdown = {
      require("formatter.filetypes.markdown").prettier,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}

local formatGroup =
  vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = ":silent FormatWrite",
  pattern = "*",
  group = formatGroup,
})

--local navbuddy = require("nvim-navbuddy")

require('gitsigns').setup()

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
	    'rg',
	    '--hidden',
	    '--color=never',
	    '--no-heading',
	    '--with-filename',
	    '--line-number',
	    '--column',
	    '--smart-case',
            '--glob',
            '!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}'
    },
    layout_strategy = "vertical",
    wrap_results = true,
    sorting_strategy = "ascending",
    layout_config = {
        vertical = {
	    width = 0.99,
            height = 0.99,
            },
        }
  },
  pickers = {
    oldfiles = {
      initial_mode = "normal"
    },
    find_files = {
      find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }
    }
  },
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}

require("telescope").load_extension "file_browser"

-- Telescope
vim.keymap.set(
  "n",
  "<leader>ft",
  require("telescope.builtin").find_files,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>fe",
  function() require("telescope.builtin").find_files({ cwd = "/home/niels/repos" }) end,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>fr",
  function()
    local repo_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    require("telescope.builtin").find_files({ cwd = repo_root })
  end,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>fg",
  require("telescope.builtin").live_grep,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>fd",
  function() require("telescope.builtin").live_grep({ cwd = "/home/niels/repos" }) end,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>ff",
  function()
    local repo_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    require("telescope.builtin").live_grep({ cwd = repo_root })
  end,
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<space>nb",
  ":Navbuddy<CR>",
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>fd",
  function() require("telescope.builtin").live_grep({ cwd = "/home/niels/repos" }) end,
  { noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>dr',
  '<cmd>DiffviewFileHistory<cr>',
  { desc = 'Repo history' }
)

vim.keymap.set(
  'n',
  '<leader>df',
  '<cmd>DiffviewFileHistory --follow %<cr>',
  { desc = 'File history' }
)

vim.keymap.set(
  'n',
  '<leader>do',
  ':DiffviewOpen<cr>',
  { desc = 'Open diff view' }
)

vim.keymap.set(
  'n',
  '<leader>dc',
  ':DiffviewClose<cr>',
  { desc = 'Close diff view' }
)
