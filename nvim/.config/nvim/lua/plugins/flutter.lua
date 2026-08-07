return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
    },
    keys = {
      { "<leader>Fr", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Hot Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>Fd", "<cmd>FlutterDetach<cr>", desc = "Flutter Detach" },
      { "<leader>Fc", "<cmd>Telescope flutter commands<cr>", desc = "Flutter Menú Comandos" },
    },
    config = function()
      -- Obtenemos las capacidades de cmp-nvim-lsp para conectarlas con Dart
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("flutter-tools").setup {
        dev_log = {
          enabled = true,
          open_cmd = "botright 15split"
        },
        ui = {
          border = "rounded",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          }
        },
        widget_guides = {
          enabled = true,
        },
        lsp = {
          capabilities = capabilities, -- ¡Esta es la línea mágica que conecta todo!
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          }
        }
      }
    end,
  }
}
