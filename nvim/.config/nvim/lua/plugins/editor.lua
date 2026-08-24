return {
  -- Navegación herdr <-> tmux <-> neovim (vim-herdr-navigation).
  -- Ctrl+h/j/k/l mueve entre splits de neovim y, en el borde, salta al pane
  -- herdr vecino. Cae en vim-tmux-navigator dentro de tmux y en wincmd plano
  -- en cualquier otro sitio. El script vive vendoreado en el paquete herdr
  -- de los dotfiles.
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      -- Los mappings reales los define vim-herdr-navigation abajo
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      local nav = vim.fn.expand("~/.config/herdr/plugins/vim-herdr-navigation/editor/nvim.lua")
      if vim.fn.filereadable(nav) == 1 then
        dofile(nav)
      end
      -- Sin paquete herdr stoweado, quedan los mappings fallback de
      -- config/keymaps.lua: <C-h/j/k/l> -> <C-w>h/j/k/l
    end,
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
        filters = {
          git_ignored = false,
        },
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
