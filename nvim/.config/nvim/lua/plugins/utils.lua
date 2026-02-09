return {

  -- ========================================================================
  -- 1. PARENTESIS Y COMILLAS AUTOMÁTICOS (Autopairs)
  -- ========================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Usar treesitter para ser más inteligente
      ts_config = {
        lua = { "string" }, -- No añadir pares en strings de lua
      },
    },
  },

  -- ========================================================================
  -- 2. COMENTARIOS RÁPIDOS (Comment.nvim)
  -- ========================================================================
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Mantiene los atajos por defecto:
      -- `gcc` para comentar una línea
      -- `gbc` para comentar en bloque
      -- `gc` + movimiento (ej: `gc2j`) para comentar varias líneas
    },
  },

  -- ========================================================================
  -- 3. MANIPULACIÓN DE ALREDEDORES (Surround)
  -- ========================================================================
  {
    "kylechui/nvim-surround",
    version = "*", 
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Atajos por defecto (muy potentes):
        -- ys iw "  -> You Surround inner word con " -> "palabra"
        -- ds "     -> Delete Surround "             -> palabra
        -- cs "'    -> Change Surround " a '         -> 'palabra'
      })
    end,
  },

  -- ========================================================================
  -- 4. INTERFAZ MEJORADA (Dressing)
  -- ========================================================================
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = true },
      select = { enabled = true, backend = { "telescope", "builtin" } },
    },
  },

  -- ========================================================================
  -- 5. REPL / ENVIAR CÓDIGO A TMUX (Vim-Slime Vitaminado)
  -- ========================================================================
  {
    "jpalardy/vim-slime",
    init = function()
      -- Configuración base
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 1 -- ¡CRUCIAL! Evita que Python se rompa con la indentación al pegar
      
      -- Configuración inteligente de panel
      -- "{last}" significa: "Envía al último panel de Tmux que toqué antes de venir a Vim".
      -- Esto es mejor que "{right-of}" porque te permite tener el REPL abajo, a la izquierda o donde sea.
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}", 
      }
      vim.g.slime_dont_ask_default = 1 -- No preguntar siempre al iniciar
    end,
    config = function()
      local keymap = vim.keymap

      -- --- TUS MAPEOS PERSONALIZADOS (Prefijo <leader>s = Send) ---

      -- 1. Enviar línea actual (Modo Normal)
      keymap.set("n", "<leader>ss", "<Plug>SlimeLineSend", { desc = "Enviar línea actual" })
      
      -- 2. Enviar selección (Modo Visual)
      keymap.set("x", "<leader>ss", "<Plug>SlimeRegionSend", { desc = "Enviar selección" })

      -- 3. Enviar párrafo completo (Bloque de código actual) - ¡Muy útil!
      keymap.set("n", "<leader>sp", "<Plug>SlimeParagraphSend", { desc = "Enviar párrafo" })

      -- 4. Enviar TODO el archivo
      -- Lógica: Selecciona todo (ggVG) y lo envía.
      keymap.set("n", "<leader>sa", ":%SlimeSend<CR>", { desc = "Enviar archivo completo" })

      -- 5. (Lo que pediste) Enviar desde el INICIO hasta la línea ACTUAL
      -- Lógica: Marca posición (mz), Visual hasta arriba (vgg), Envía plugin, Vuelve a posición (`z)
      keymap.set("n", "<leader>st", "mz vgg <Plug>SlimeRegionSend `z", { desc = "Enviar desde Top hasta Aquí" })
      
      -- 6. Configurar panel destino manualmente (por si falla la detección)
      keymap.set("n", "<leader>sc", "<Plug>SlimeConfig", { desc = "Configurar Slime Target" })
    end,
  },  
  -- ========================================================================
  -- 6. GESTIÓN DE GIT DESDE NVIM (Lazygit)
  -- ========================================================================
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- Dependencia opcional para que se cargue con el resto
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit" }
    }
  }
}
