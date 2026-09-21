# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repo for macOS development environment. Managed via symlinks. Covers: zsh, Neovim, WezTerm, tmux, Starship prompt.

## Setup & Deployment

**Automated setup (recommended):**
```bash
# Clone repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Run setup script
./setup.sh
```

Setup script:
- Detects OS (macOS/Linux)
- Installs dependencies via package manager
- Clones gpakosz/.tmux framework
- Creates all symlinks
- Auto-installs zsh plugins on first shell launch

**Manual setup (legacy):**
```bash
# Review symlinks first
cat symlinks.sh

# Manual symlink creation - review each line before executing
# Source format: $(pwd)/directory/file:$HOME/destination
```

**Tmux:**
- Framework: gpakosz/.tmux (auto-cloned by setup.sh)
- Config: `tmux/.tmux.conf.local` copied to `~/.tmux.conf.local`
- Git status: `tmux/gitmux.conf` symlinked to `~/.tmux/gitmux.conf`

**WezTerm:**
- Auto-launches tmux via `default_prog` (wezterm.lua:44)
- Background image symlinked from `img/dark-desert.jpg`

**Zsh plugins:**
- 5 plugins auto-install on first shell launch via `plugins.zsh`
- Plugins stored in `~/.config/zsh/plugins/` (gitignored)
- Update via `zplugin-update` command

## Configuration Structure

### Zsh (`zsh/`)
Modular config. Entry: `.zshrc` (148 lines, sources all modules).

Modules loaded in `.zshrc:98-113`:
- `fzf.zsh` - fuzzy finder config (multi-platform)
- `aliases.zsh` - git/eza/kubectl shortcuts
- `bindings.zsh` - custom keymaps
- `plugins.zsh` - plugin manager (auto-installs 5 plugins)
- `prompt.zsh` - starship prompt
- `local.zsh` - machine-specific overrides (gitignored)

Plugins (auto-installed):
- `fast-syntax-highlighting` - syntax highlighting
- `zsh-autosuggestions` - command suggestions
- `zsh-history-substring-search` - substring history search
- `zsh-uv-env` - UV environment activation
- `zsh-vi-mode` - vi keybindings

Config: XDG-compliant (`.zshenv` sets `XDG_CONFIG_HOME`, `XDG_CACHE_HOME`, etc.)

Update plugins: `zplugin-update` command

### Neovim (`nvim/.config/nvim/`)
Lazy.nvim-based. Entry: `init.lua` → loads `imroot.core`, `imroot.lazy`, `current-theme`, `imroot.terminalpop`.

Architecture:
- `lua/imroot/core/` - options & keymaps
- `lua/imroot/plugins/` - plugin specs (auto-imported by lazy.lua:16-17)
- `lua/imroot/plugins/lsp/` - LSP configs

Plugin modules: avante, colorscheme, telescope, treesitter, nvim-cmp, lualine, harpoon, oil, formatting, linting, debugging, gitstuff, etc.

### WezTerm (`wezterm/.config/wezterm/`)
Single file: `wezterm.lua`. Launches tmux on startup. Tokyo Night theme. Custom events: toggle opacity, toggle ligatures.

## Common Commands

**Test configs without breaking system:**
```bash
# Zsh - dry-run new config
zsh -c 'source ./zsh/.zshrc && echo "Config loads"'

# Neovim - test from repo dir
nvim -u nvim/.config/nvim/init.lua

# Check symlink status
ls -l ~/.zshrc ~/.config/nvim ~/.config/wezterm
```

**Update symlinks after changes:**
```bash
# Remove old symlink
rm ~/.config/nvim

# Re-create (adjust path to repo root)
ln -s $(pwd)/nvim/.config/nvim ~/.config/nvim
```

**Neovim plugin management:**
```bash
# Inside nvim
:Lazy sync     # Update all plugins
:Lazy restore  # Restore to lockfile state
:Lazy clean    # Remove unused plugins
```

## Important Notes

- All config symlinked - edit in repo, changes apply immediately (except zsh - needs `source ~/.zshrc`)
- WezTerm auto-reloads (wezterm.lua:50)
- Gitignored: `.DS_Store`, `wezterm/*.jpg`, `zsh/local.zsh`, `zsh/plugins/`
- Zsh plugins auto-install on first launch (not git submodules)
- Zsh modules source from `$ZDOTDIR` (`$XDG_CONFIG_HOME/zsh`)
- Homebrew paths support both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`)
- Conda/NVM/GCloud initialized at end of `.zshrc`

## Platform Support

**macOS:**
- Full support via Homebrew
- All tools installable via `setup.sh`

**Linux:**
- Debian/Ubuntu: Core tools via apt (starship/zoxide/eza need manual install)
- RHEL/Fedora: Core tools via dnf
- Arch: Core tools via pacman
- Zsh plugins work identically across platforms
