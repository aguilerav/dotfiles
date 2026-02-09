local opt = vim.opt

-- Líneas y Números
opt.number = true          -- Muestra número de línea actual
opt.relativenumber = true  -- Muestra números relativos (útil para saltos con jk)
opt.cursorline = true      -- Resalta la línea donde está el cursor
opt.signcolumn = "yes"     -- Siempre muestra la columna de signos (evita saltos visuales)

-- Tabulaciones e Indentación
opt.tabstop = 2        -- Tamaño visual del tab
opt.shiftwidth = 2     -- Tamaño de la indentación
opt.expandtab = true   -- Convierte tabs en espacios
opt.autoindent = true  -- Copia indentación de la línea anterior

-- Búsqueda
opt.ignorecase = true  -- Ignora mayúsculas al buscar...
opt.smartcase = true   -- ...a menos que escribas una mayúscula

-- Apariencia
opt.termguicolors = true   -- Colores reales (24-bit)
opt.background = "dark"    -- Fondo oscuro por defecto
opt.wrap = false           -- No cortar líneas largas automáticamente

-- Comportamiento de Ventanas (Splits)
opt.splitright = true      -- Splits verticales se abren a la derecha
opt.splitbelow = true      -- Splits horizontales se abren abajo

-- Portapapeles del Sistema
-- Esto permite copiar con 'y' y pegar fuera de Neovim con Ctrl+V
opt.clipboard:append("unnamedplus")

-- Varios
opt.iskeyword:append("-")  -- Considera palabras con guion como una sola (ej: kebab-case)
opt.updatetime = 50        -- Rapidez para mostrar popups/cambios (defecto es 4000ms)
