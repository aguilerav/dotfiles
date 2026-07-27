return {

  -- ========================================================================
  -- 1. TEMA DE COLORES (Tokyonight)
  -- ========================================================================
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "night", transparent = true },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- ========================================================================
  -- 2. BARRA DE ESTADO INFERIOR (Lualine)
  -- ========================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function()
      local lazy_status = require("lazy.status")
      return {
        options = {
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      }
    end,
  },

  -- ========================================================================
  -- 3. BARRA DE PESTAÑAS SUPERIOR (Bufferline)
  -- ========================================================================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    event = "VeryLazy",
    opts = {
      options = {
        -- Nota: Usabas 'tabs'. Lo moderno suele ser 'buffers', pero respeto tu config.
        -- Si quieres ver todos los archivos abiertos arriba, cambia esto a 'buffers'.
        mode = "tabs", 
        separator_style = "thin",
      },
    },
  },

  -- ========================================================================
  -- 4. GUÍAS DE INDENTACIÓN (Indent Blankline)
  -- ========================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "┊" },
      scope = { enabled = false }, -- Desactiva scope para que sea más limpio (opcional)
    },
  }
}
