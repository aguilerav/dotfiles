-- Definir tecla líder (ESPACIO)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

-- --- GENERAL ---

-- Guardar y Salir rápido
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Guardar archivo" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Salir" })

-- Usar 'jk' para salir del modo Insertar (Súper cómodo)
keymap.set("i", "jk", "<ESC>", { desc = "Salir de Insert Mode" })

-- Limpiar resaltado de búsqueda (con Esc también funciona en configs modernas, pero mantenemos líder)
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Limpiar búsqueda" })

-- Borrar carácter sin copiar al portapapeles
keymap.set("n", "x", '"_x')

-- --- VENTANAS (Splits) ---
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Igualar tamaño splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Cerrar split actual" })

-- --- NAVEGACIÓN ENTRE PANELES (Integración con Tmux) ---
-- Esto preparará el terreno para el plugin vim-tmux-navigator después.
-- Por ahora, navegarás entre splits de neovim con Ctrl+h/j/k/l
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Ir al split izquierdo" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Ir al split inferior" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Ir al split superior" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Ir al split derecho" })
