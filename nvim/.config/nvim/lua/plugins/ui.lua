return {

   -- ========================================================================
  -- BARRA DE PESTAÑAS SUPERIOR (Bufferline)
  -- ========================================================================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs", 
        separator_style = "thin",
      },
    },
  },

  -- ========================================================================
  -- GUÍAS DE INDENTACIÓN (Indent Blankline)
  -- ========================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "┊" },
    },
  }
}
