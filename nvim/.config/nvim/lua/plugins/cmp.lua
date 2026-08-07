return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Solo se carga cuando empiezas a escribir
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- Autocompletado desde el LSP (el cerebro)
    "hrsh7th/cmp-buffer",       -- Sugiere palabras que ya están en el archivo
    "hrsh7th/cmp-path",         -- Autocompleta rutas de archivos (ej: ../assets/)
    "L3MON4D3/LuaSnip",         -- Motor de fragmentos de código (Snippets)
    "saadparwaiz1/cmp_luasnip", -- Conecta LuaSnip con CMP
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Requerido para que los snippets funcionen
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Ctrl+k para subir en el menú
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Ctrl+j para bajar en el menú
        ["<C-Space>"] = cmp.mapping.complete(),     -- Ctrl+Espacio para forzar el menú
        ["<C-e>"] = cmp.mapping.abort(),            -- Ctrl+e para cerrar el menú sin elegir
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter para confirmar sugerencia
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Prioridad 1: Sugerencias de código (Dart/Flutter)
        { name = "luasnip" },  -- Prioridad 2: Snippets
        { name = "buffer" },   -- Prioridad 3: Palabras en el texto
        { name = "path" },     -- Prioridad 4: Rutas
      }),
    })
  end,
}
