# AGENTS.md

Dotfiles managed with **GNU Stow**: every top-level directory is a package that mirrors `$HOME`
(e.g. `nvim/.config/nvim/` → `~/.config/nvim/`, `zsh/.zshrc` → `~/.zshrc`).
This repo also stows the global OpenCode config you're running in (`opencode/.config/opencode/` → `~/.config/opencode/`).

## Constraints that will bite you

- **Repo must live at `~/dotfiles`.** `.zshrc` sources plugins from `~/dotfiles/zsh/plugins/...`,
  defines `dot='cd ~/dotfiles'`, and `install.sh` does `cd ~/dotfiles`. Relocating the repo breaks zsh.
- **Edits here are live.** Stow symlinks configs into `$HOME`, so changes take effect on the running system
  immediately (`source ~/.zshrc`, restart herdr/tmux/nvim to see them). Don't "test" by committing first.
- **`install.sh` supports macOS + Ubuntu/Debian** (detects via `uname -s`; `brew` on macOS, `apt` on Linux)
  and stows **8 packages**: `zsh`, `tmux`, `nvim`, `starship`, `wezterm`, `yazi` (folding) and
  `herdr`, `opencode` (**`--no-folding`**, because they write runtime state — socks/logs/`plugins.json`/`node_modules` —
  into their `~/.config` dir; folding would dump that state into the git repo).
  It aborts on Termux/Android and unsupported OSes. **Termux and Windows (WSL2) install manually** → `INSTRUCTIONS.md`.
- **Never move existing `~/.config/{herdr,opencode}` to backup** in `install.sh`: they hold live runtime state.
- **`.DS_Store` breaks stow.** macOS Finder drops them inside packages; without a `nvim/.stow-local-ignore` /
  `opencode/.stow-local-ignore` (regex `\.DS_Store`) stow fails with conflicts. If you add a new package,
  give it a `.stow-local-ignore` too if Finder could touch it.

## Layout & conventions

- `zsh/plugins/` holds **vendored full upstream copies** of zsh-autosuggestions, zsh-syntax-highlighting
  and zsh-autocomplete (not submodules, no plugin manager). Update by re-copying from upstream;
  never hand-edit vendored files. zsh-autocomplete **must** load after `bindkey -v` and runs `compinit`
  itself (removed from `.zshrc` section 1); zsh-syntax-highlighting must be sourced last.
- `nvim/.config/nvim/lua/plugins/*.lua`: lazy.nvim **auto-imports every file in this dir** — add a plugin by
  creating a new file there. Entrypoint chain: `init.lua` → `config/{options,keymaps,lazy}.lua`.
  Commit `lazy-lock.json` (pins plugin versions). Note: no treesitter is actually configured (README claim is stale).
- **herdr is the primary multiplexer**: `.config/herdr/config.toml` (prefix **C-a**), plugin
  `vim-herdr-navigation` gives `Ctrl+h/j/k/l` pane↔nvim-split navigation (`navigate.sh` on the herdr side,
  `editor/nvim.lua` dofile'd from nvim's `editor.lua`). After `stow --no-folding herdr`, the plugin must be
  registered once: `herdr plugin link ~/.config/herdr/plugins/vim-herdr-navigation` (registry = `plugins.json`,
  runtime, not in git). `Prefix d` = dev layout; `Prefix alt+g` = lazygit popup.
- `tmux/.tmux.conf` is the **fallback** multiplexer (used on Termux or when herdr is absent): prefix **C-a**,
  `Ctrl+h/j/k/l` smart pane switching via vim-tmux-navigator inside nvim. `Prefix g` = lazygit popup; `Prefix X` = kill session.
- Cross-platform by design: `.zshrc` branches on `uname -s` (Homebrew on macOS, `ls` flags per OS);
  `install.sh` branches on `uname -s` (brew/apt); `wezterm.lua` uses macOS-specific blur.
  Termux has no herdr/wezterm/opencode (only zsh, tmux, nvim, starship, yazi). Keep conditionals when adding shell logic.
- `~/.zshrc.local` is sourced by `.zshrc` for machine-specific overrides — never commit machine-local settings.
- Docs (`README.md`, `INSTRUCTIONS.md`, `CHEAT_SHEET.md`) and code comments are in **Spanish**; match that in new configs/docs.
  `README.md` is the repo guide, `INSTRUCTIONS.md` the per-OS install guide, `CHEAT_SHEET.md` the keybinding reference —
  point users there instead of restating shortcuts. `ollama/` is untracked and intentionally undocumented.

## OpenCode config (owned by this repo)

- Global agents: `opencode/.config/opencode/agents/{ask,plan,build,expert}.md` — model, temperature,
  and permissions are per-agent frontmatter.
- `opencode.json` is JSONC (comments allowed). Default model `deepseek/deepseek-v4-pro`,
  `small_model` `deepseek/deepseek-v4-flash`, `default_agent` `build`.
- Global permission defaults: read/glob/grep/list/lsp/task = allow; edit/write/external_directory/bash = ask.

## Workflow

- `ws` (`workspace` in `.zshrc`) spawns the intended daily setup as a tmux session:
  nvim (left) + opencode (right) + shell (bottom). In herdr, the equivalent is `Prefix d` (dev layout).
- No tests, CI, or linters exist for dotfiles. Verify manually: `zsh -n ~/.zshrc`, `tmux source-file ~/.tmux.conf`,
  `bash -n install.sh`, `stow -n <pkg>` before real stows.
