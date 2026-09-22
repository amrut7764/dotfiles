#!/usr/bin/env zsh
# Post-setup script to reload shell configuration
# Run after pulling changes or modifying configs

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

# =========================================================
# Banner
# =========================================================

cat << "EOF"
╔═══════════════════════════════════════════════════╗
║          Dotfiles Post-Setup Script               ║
╚═══════════════════════════════════════════════════╝
EOF

echo ""
log_info "Reloading shell configuration..."
echo ""

# =========================================================
# Source Environment
# =========================================================

# Load .zshenv first to set ZDOTDIR
if [[ -f "$HOME/.zshenv" ]]; then
  source "$HOME/.zshenv"
  log_info "Loaded .zshenv (ZDOTDIR=$ZDOTDIR)"
else
  log_warn ".zshenv not found. Run setup.sh first."
  exit 1
fi

# Now source .zshrc with ZDOTDIR set
if [[ -f "$HOME/.zshrc" ]]; then
  source "$HOME/.zshrc"
  log_info "Loaded .zshrc"
else
  log_warn ".zshrc not found. Run setup.sh first."
  exit 1
fi

# =========================================================
# Reload Tmux Config (if in tmux)
# =========================================================

if [[ -n "$TMUX" ]]; then
  log_info "Detected tmux session"
  if [[ -f "$HOME/.tmux.conf" ]]; then
    tmux source-file "$HOME/.tmux.conf"
    log_info "Reloaded tmux config"
  fi
fi

# =========================================================
# Summary
# =========================================================

echo ""
log_info "Configuration reloaded successfully!"
echo ""
echo "Active configurations:"
echo "  - Zsh: $HOME/.zshrc"
echo "  - ZDOTDIR: $ZDOTDIR"
[[ -n "$TMUX" ]] && echo "  - Tmux: $HOME/.tmux.conf"
echo ""
log_warn "Note: Some changes may require a full shell restart."
log_info "To restart shell: exec zsh"
