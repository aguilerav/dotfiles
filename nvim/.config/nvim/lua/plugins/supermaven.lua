return {
  "supermaven-inc/supermaven-nvim",
  -- event = "InsertEnter", -- Solo se carga cuando empiezas a escribir (igual que cmp)
  config = function()
    require("supermaven-nvim").setup({
      -- Modo inline ghost text (default, pero explícito para claridad).
      -- Las sugerencias de Supermaven viven como texto fantasma al final
      -- de la línea, separadas del menú de cmp (que es solo LSP/snippets).
      disable_inline_completion = false,
      keymaps = {
        accept_suggestion = "<Tab>",  -- Aceptar sugerencia completa
        clear_suggestion = "<C-]>",   -- Cerrar la sugerencia
        accept_word = "<C-Right>",    -- Aceptar palabra por palabra (cambiado de <C-j>
        -- para no chocar con la navegación del menú de cmp)
      },
    })
  end,
}
