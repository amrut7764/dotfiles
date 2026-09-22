#!/usr/bin/env bash
# Uninstall script for dotfiles
# Removes all symlinks and cloned frameworks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

confirm() {
  read -p "$1 [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# =========================================================
# Banner
# =========================================================

cat << "EOF"
╔═══════════════════════════════════════════════════╗
║          Dotfiles Uninstall Script                ║
╚═══════════════════════════════════════════════════╝
EOF

echo ""
log_warn "This will remove all dotfiles symlinks and configurations."
echo ""

if ! confirm "Continue with uninstall?"; then
  log_info "Uninstall cancelled"
  exit 0
fi

echo ""

# =========================================================
# Remove Symlinks
# =========================================================

log_info "Removing symlinks..."

# Zsh
rm -f "$HOME/.zshrc"
rm -f "$HOME/.zshenv"
rm -f "$HOME/.config/zsh/.zshrc"
rm -f "$HOME/.config/zsh/aliases.zsh"
rm -f "$HOME/.config/zsh/bindings.zsh"
rm -f "$HOME/.config/zsh/fzf.zsh"
rm -f "$HOME/.config/zsh/plugins.zsh"
rm -f "$HOME/.config/zsh/prompt.zsh"

# Starship
rm -f "$HOME/.config/starship/starship.toml"

# Neovim
rm -f "$HOME/.config/nvim"

# WezTerm
rm -f "$HOME/.config/wezterm"
rm -f "$HOME/.config/wezterm/dark-desert.jpg"

# Tmux
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.tmux/gitmux.conf"

log_info "Symlinks removed"

# =========================================================
# Remove Configurations
# =========================================================

if confirm "Remove tmux configuration files? (~/.tmux.conf.local)"; then
  rm -f "$HOME/.tmux.conf.local"
  log_info "Tmux config removed"
fi

if confirm "Remove local zsh config? (~/.config/zsh/local.zsh)"; then
  rm -f "$HOME/.config/zsh/local.zsh"
  log_info "Local zsh config removed"
fi

# =========================================================
# Remove Cloned Frameworks
# =========================================================

if confirm "Remove gpakosz/.tmux framework? (~/.tmux/)"; then
  rm -rf "$HOME/.tmux"
  log_info "Tmux framework removed"
fi

# =========================================================
# Remove Plugin Directories
# =========================================================

if confirm "Remove zsh plugins? (~/.config/zsh/plugins/)"; then
  rm -rf "$HOME/.config/zsh/plugins"
  log_info "Zsh plugins removed"
fi

# =========================================================
# Clean Empty Directories
# =========================================================

log_info "Cleaning empty directories..."

rmdir "$HOME/.config/zsh" 2>/dev/null || true
rmdir "$HOME/.config/starship" 2>/dev/null || true

# =========================================================
# Summary
# =========================================================

echo ""
log_info "Uninstall complete!"
echo ""
echo "Removed:"
echo "  - All dotfiles symlinks"
echo "  - Configuration files (if selected)"
echo "  - Cloned frameworks (if selected)"
echo ""
log_warn "Note: Installed packages (starship, eza, zoxide, etc.) were NOT removed."
log_warn "To uninstall packages, use your package manager (brew, apt, etc.)."
echo ""
log_info "To restore default shell config, restart your terminal."
