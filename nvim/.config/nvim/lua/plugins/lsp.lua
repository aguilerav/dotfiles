return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Estos atajos solo se activarán cuando un servidor LSP (como el de Dart) esté funcionando
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Ir a la definición"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        opts.desc = "Mostrar documentación"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Acciones de código (Quick Fix)"
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Renombrar variable en todo el proyecto"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        
        opts.desc = "Ver problemas/errores en la línea"
        keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      end,
    })
  end,
}
