-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Aquí Lazy buscará automáticamente cualquier archivo lua dentro de lua/plugins
    -- y lo cargará como un plugin. ¡Esto hace todo muy ordenado!
    { import = "plugins" },
  },
  -- Colores para la ventana de instalación
  install = { colorscheme = { "habamax" } },
  -- Verificar actualizaciones sin molestar
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
