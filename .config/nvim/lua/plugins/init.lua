return {
  {
    "NLKNguyen/papercolor-theme",
    priority = 1000,
    config = function()
      -- Blank to address startup error
    end,
    init = function()
      vim.opt.termguicolors = true
      vim.o.background = "light"
      vim.cmd.colorscheme "PaperColor"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
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
    end,
  },
}
