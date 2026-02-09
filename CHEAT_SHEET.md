# ⌨️ Cheat Sheet: The Indestructible Setup

Resumen de los atajos de teclado y comandos principales para este entorno (Zsh + Tmux + Neovim).

---

## ⚡ Tmux (Multiplexer)
**Prefijo Global:** `Ctrl` + `a` (Reemplaza al defecto Ctrl+b)

### 🪟 Gestión de Paneles y Ventanas
| Atajo | Acción |
| :--- | :--- |
| `<Prefix> \|` | Dividir pantalla **Verticalmente** |
| `<Prefix> -` | Dividir pantalla **Horizontalmente** |
| `<Prefix> x` | Cerrar panel actual |
| `<Prefix> c` | Crear nueva ventana (pestaña) |
| `<Prefix> n` | Siguiente ventana |
| `<Prefix> p` | Ventana anterior |
| `<Prefix> ,` | Renombrar ventana actual |
| `<Prefix> m` | **Zoom** (Maximizar/Restaurar panel) |

### 🧭 Navegación (Estilo Vim)
Funciona igual en Tmux y dentro de Neovim.

| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `h` | Moverse a la **Izquierda** |
| `Ctrl` + `j` | Moverse **Abajo** |
| `Ctrl` + `k` | Moverse **Arriba** |
| `Ctrl` + `l` | Moverse a la **Derecha** |

### 📐 Redimensionar Paneles
| Atajo | Acción |
| :--- | :--- |
| `<Prefix> H` | Agrandar hacia la Izquierda |
| `<Prefix> J` | Agrandar hacia Abajo |
| `<Prefix> K` | Agrandar hacia Arriba |
| `<Prefix> L` | Agrandar hacia la Derecha |

### ⚙️ Sesiones
| Atajo | Acción |
| :--- | :--- |
| `<Prefix> d` | Desconectar sesión (Detach) |
| `<Prefix> s` | Listar y cambiar entre sesiones |
| `<Prefix> r` | Recargar configuración (`.tmux.conf`) |

---

## 📝 Neovim (Editor)
**Tecla Líder:** `Espacio`

### 📂 Archivos y Búsqueda
| Atajo | Acción |
| :--- | :--- |
| `<Espacio> e` | Abrir/Cerrar Árbol de Archivos (NvimTree) |
| `<Espacio> ff` | Buscar Archivos (Telescope) |
| `<Espacio> fs` | Buscar Texto dentro de archivos (Grep) |
| `<Espacio> fr` | Archivos Recientes |
| `<Espacio> w` | Guardar archivo |
| `<Espacio> q` | Salir |

### 🖥️ Edición y Ventanas
| Atajo | Acción |
| :--- | :--- |
| `jk` (modo insert) | Salir a modo Normal (Esc) |
| `<Espacio> nh` | Limpiar resaltado de búsqueda |
| `<Espacio> sv` | Split Vertical |
| `<Espacio> sh` | Split Horizontal |
| `<Espacio> se` | Igualar tamaño de splits |
| `<Espacio> sx` | Cerrar split actual |

### 🚀 REPL / Enviar a Tmux (Vim-Slime)
Envía código desde Neovim al panel de terminal activo en Tmux.

| Atajo | Acción |
| :--- | :--- |
| `<Espacio> ss` | Enviar **línea actual** o **selección** |
| `<Espacio> sp` | Enviar **párrafo** (bloque de código) |
| `<Espacio> sa` | Enviar **archivo completo** |
| `<Espacio> sc` | Reconfigurar panel destino |

### 🛠️ Utilidades
| Atajo | Acción |
| :--- | :--- |
| `<Espacio> rn` | Renombrar variable (si usas LSP/Refactor) |
| `<Espacio> gg` | Abrir LazyGit (si está instalado) |
| `gcc` | Comentar línea |
| `gbc` | Comentar bloque |

---

## 🐚 Zsh (Terminal)
Atajos nativos de la shell configurados por defecto.

| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `r` | Buscar en el historial de comandos |
| `Ctrl` + `l` | Limpiar pantalla |
| `!!` | Repetir último comando |
| `cd -` | Ir al directorio anterior |
