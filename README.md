# Dotfiles

Personal development environment configuration for macOS and Linux. Covers: zsh, Neovim, WezTerm, tmux, Starship prompt.

## Quick Start

```bash
# Clone repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Run automated setup
./setup.sh
```

Setup script will:
- Install dependencies (Homebrew packages on macOS, apt/dnf/pacman on Linux)
- Clone gpakosz/.tmux framework
- Create all symlinks
- Configure zsh with 5 auto-installing plugins

After setup:
1. Restart terminal or `source ~/.zshrc`
2. Launch `nvim` (plugins auto-install on first run)
3. Launch `wezterm` (auto-starts tmux)

## What's Included

**Shell:**
- Zsh with modular config (`.zshrc`, `.zshenv`, `aliases.zsh`, `bindings.zsh`, `fzf.zsh`, `plugins.zsh`, `prompt.zsh`)
- 5 zsh plugins (auto-install on first launch): syntax highlighting, autosuggestions, history search, vi-mode, uv-env
- Starship prompt

**Terminal:**
- WezTerm config with Tokyo Night theme
- Tmux config via gpakosz/.tmux framework
- Git status in tmux via gitmux

**Editor:**
- Neovim with Lazy.nvim plugin manager
- LSP, treesitter, telescope, nvim-cmp, lualine, harpoon, oil, etc.

**Tools:**
- zoxide (smart cd)
- eza (modern ls)
- lazygit
- fzf (fuzzy finder)
- bat (cat with syntax highlighting)

## Platform Support

**macOS:** Full support via Homebrew

**Linux:**
- Debian/Ubuntu: Core tools via apt (some require manual install)
- RHEL/Fedora: Core tools via dnf
- Arch: Core tools via pacman

Zsh plugins work identically across platforms.

## Manual Setup

For manual setup or troubleshooting, see `symlinks.sh` for all symlink mappings.

## Configuration

**Machine-specific config:**
Edit `~/.config/zsh/local.zsh` (gitignored)

**Update zsh plugins:**
```bash
zplugin-update
```

**Update Neovim plugins:**
```vim
:Lazy sync
```

## Structure

```
.
├── zsh/                # Zsh config (modular)
│   ├── .zshrc          # Main config (148 lines)
│   ├── .zshenv         # XDG environment vars
│   ├── aliases.zsh     # Git/eza/kubectl aliases
│   ├── bindings.zsh    # Custom keybindings
│   ├── fzf.zsh         # Fuzzy finder config
│   ├── plugins.zsh     # Plugin manager (auto-install)
│   └── prompt.zsh      # Starship prompt
├── nvim/               # Neovim config (Lazy.nvim)
├── wezterm/            # WezTerm terminal config
├── tmux/               # Tmux config + gitmux
├── starship/           # Starship prompt config
├── img/                # Background images
├── setup.sh            # Automated setup script
└── symlinks.sh         # Manual symlink reference
```

See `CLAUDE.md` for detailed architecture notes.
