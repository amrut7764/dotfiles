# Dotfiles

Personal development environment configuration for macOS and Linux. Covers: zsh, Neovim, WezTerm, tmux, Starship prompt.

## Requirements

**Nerd Font:** Install in terminal emulator for proper tmux/starship icons:
- macOS: Download from [Nerd Fonts](https://www.nerdfonts.com/), install via Font Book, configure in terminal preferences
- Linux: See manual install instructions below

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

### Linux Manual Tool Install

Some tools need manual binary install on Linux. Download correct architecture:

**Check architecture:**
```bash
uname -m  # x86_64 or aarch64
```

**Starship (prompt):**
```bash
curl -sS https://starship.rs/install.sh | sh
```

**eza (modern ls):**
```bash
# x86_64
wget https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz
tar -xzf eza_x86_64-unknown-linux-gnu.tar.gz

# ARM64 (Raspberry Pi)
wget https://github.com/eza-community/eza/releases/latest/download/eza_aarch64-unknown-linux-gnu.tar.gz
tar -xzf eza_aarch64-unknown-linux-gnu.tar.gz

# Install
sudo mv eza /usr/local/bin/
rm eza_*.tar.gz
```

**zoxide (smart cd):**
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

**Nerd Font (for tmux/starship icons):**
```bash
# Install Hack Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip
rm Hack.zip
fc-cache -fv

# Configure terminal to use "Hack Nerd Font"
# Then reconnect SSH session
```

After install: `source ~/.zshrc`

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
