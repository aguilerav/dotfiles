return {
  -- Navegación Tmux <-> Neovim
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  -- Explorador de archivos (Nvim-Tree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = { relativenumber = true, width = 30 },
        actions = { open_file = { quit_on_open = true } },
      })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    end,
  },

  -- Buscador (Telescope - Versión Portable)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Solo Lua, nada de C
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Buscar texto" }) -- Requiere ripgrep instalado en el sistema
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recientes" })
    end,
  },

  -- Git Signs (Barra lateral de git)
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  
  -- Which Key (Ayuda de teclas)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  }
}
