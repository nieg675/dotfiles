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
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true })
    end,
  },
}
