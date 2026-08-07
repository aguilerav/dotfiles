return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Se activa justo antes de guardar el archivo
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Formatear archivo (Code Format)",
    },
  },
  opts = {
    -- Aquí definimos qué herramienta usar para cada lenguaje
    formatters_by_ft = {
      python = { "isort", "black" },
      -- Para Dart no ponemos nada explícito aquí porque le diremos
      -- que use el formateador que ya viene integrado en su LSP (abajo)
    },
    -- Configuración de guardado automático
    format_on_save = {
      timeout_ms = 500,     -- Si el formateador tarda más de medio segundo, se cancela para no bloquearte
      lsp_fallback = true,  -- ¡Clave para Flutter! Si no hay herramienta externa, usa el LSP de Dart
    },
  },
}
