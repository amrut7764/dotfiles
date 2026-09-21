#!/usr/bin/env bash
# Dotfiles Setup Script
# Installs dependencies, creates symlinks, configures shell environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect OS
detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ -f /etc/debian_version ]]; then
    echo "debian"
  elif [[ -f /etc/redhat-release ]]; then
    echo "redhat"
  elif [[ -f /etc/arch-release ]]; then
    echo "arch"
  else
    echo "unknown"
  fi
}

OS=$(detect_os)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info "Detected OS: $OS"
log_info "Repo root: $REPO_ROOT"

# =========================================================
# Prerequisites Check
# =========================================================

check_prerequisites() {
  log_info "Checking prerequisites..."

  # Check zsh
  if ! command -v zsh &> /dev/null; then
    log_error "zsh not found. Install it first."
    exit 1
  fi

  # Check git
  if ! command -v git &> /dev/null; then
    log_error "git not found. Install it first."
    exit 1
  fi

  # Check Homebrew on macOS
  if [[ "$OS" == "macos" ]] && ! command -v brew &> /dev/null; then
    log_warn "Homebrew not installed."
    read -p "Install Homebrew? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      log_error "Homebrew required on macOS. Exiting."
      exit 1
    fi
  fi

  log_info "Prerequisites OK"
}

# =========================================================
# Package Installation
# =========================================================

install_packages() {
  log_info "Installing packages..."

  if [[ "$OS" == "macos" ]]; then
    # Core tools
    brew install starship zoxide eza lazygit fzf tmux neovim wezterm kubectl || true
    brew install zsh-autosuggestions zsh-syntax-highlighting || true
    brew install stylua ruff biome prettier lua || true
    brew install --cask font-blex-mono-nerd-font || true
    brew install gitmux || true

    # Optional tools (interactive)
    read -p "Install Anaconda? (y/n) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && brew install --cask anaconda

    read -p "Install Google Cloud SDK? (y/n) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && brew install --cask google-cloud-sdk

  elif [[ "$OS" == "debian" ]]; then
    sudo apt update
    sudo apt install -y zsh git curl fzf tmux neovim kubectl
    log_warn "Manual install needed: starship, zoxide, eza, wezterm"
    log_warn "Visit: https://starship.rs, https://github.com/ajeetdsouza/zoxide"

  elif [[ "$OS" == "redhat" ]]; then
    sudo dnf install -y zsh git curl fzf tmux neovim
    log_warn "Manual install needed: starship, zoxide, eza, wezterm, kubectl"

  elif [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm zsh git curl fzf tmux neovim kubectl
    log_warn "Manual install needed: starship, zoxide, eza, wezterm (check AUR)"

  else
    log_error "Unsupported OS. Install packages manually."
    exit 1
  fi

  log_info "Packages installed"
}

# =========================================================
# Tmux Setup
# =========================================================

setup_tmux() {
  log_info "Setting up tmux..."

  # Clone gpakosz/.tmux framework
  if [ ! -d "$HOME/.tmux" ]; then
    log_info "Cloning gpakosz/.tmux framework..."
    git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
  else
    log_info "gpakosz/.tmux already exists"
  fi

  # Symlink .tmux.conf from framework
  ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"

  # Copy .tmux.conf.local
  cp "$REPO_ROOT/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
  log_info "Copied .tmux.conf.local to ~"

  # Symlink gitmux.conf
  if [ -f "$REPO_ROOT/tmux/gitmux.conf" ]; then
    mkdir -p "$HOME/.tmux"
    ln -sf "$REPO_ROOT/tmux/gitmux.conf" "$HOME/.tmux/gitmux.conf"
    log_info "Symlinked gitmux.conf"
  fi

  # Check gitmux installed
  if ! command -v gitmux &> /dev/null; then
    log_warn "gitmux not found. Install: https://github.com/arl/gitmux"
  fi

  log_info "Tmux setup complete"
}

# =========================================================
# Zsh Setup
# =========================================================

setup_zsh() {
  log_info "Setting up zsh..."

  # Create ~/.config/zsh/
  mkdir -p "$HOME/.config/zsh"

  # Create symlinks
  ln -sf "$REPO_ROOT/zsh/.zshrc" "$HOME/.zshrc"
  ln -sf "$REPO_ROOT/zsh/.zshenv" "$HOME/.config/zsh/.zshenv"
  ln -sf "$REPO_ROOT/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"
  ln -sf "$REPO_ROOT/zsh/bindings.zsh" "$HOME/.config/zsh/bindings.zsh"
  ln -sf "$REPO_ROOT/zsh/fzf.zsh" "$HOME/.config/zsh/fzf.zsh"
  ln -sf "$REPO_ROOT/zsh/plugins.zsh" "$HOME/.config/zsh/plugins.zsh"
  ln -sf "$REPO_ROOT/zsh/prompt.zsh" "$HOME/.config/zsh/prompt.zsh"

  log_info "Created zsh symlinks"

  # Create local.zsh from example template if doesn't exist
  if [ ! -f "$HOME/.config/zsh/local.zsh" ]; then
    cp "$REPO_ROOT/zsh/local.zsh.example" "$HOME/.config/zsh/local.zsh"
    log_info "Created local.zsh from example template"
    log_warn "Edit ~/.config/zsh/local.zsh to add machine-specific config"
  fi

  # Plugins will auto-install on first zsh launch via plugins.zsh
  log_info "Zsh plugins will auto-install on first launch"

  log_info "Zsh setup complete"
}

# =========================================================
# Neovim Setup
# =========================================================

setup_neovim() {
  log_info "Setting up Neovim..."

  # Symlink nvim config
  if [ -L "$HOME/.config/nvim" ] || [ -d "$HOME/.config/nvim" ]; then
    log_warn "~/.config/nvim already exists. Backing up to ~/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%s)"
  fi

  ln -sf "$REPO_ROOT/nvim/.config/nvim" "$HOME/.config/nvim"
  log_info "Symlinked nvim config"

  log_info "Launch nvim to auto-install plugins (may take 2-3 minutes)"
  log_info "Neovim setup complete"
}

# =========================================================
# WezTerm Setup
# =========================================================

setup_wezterm() {
  log_info "Setting up WezTerm..."

  # Symlink wezterm config
  if [ -L "$HOME/.config/wezterm" ] || [ -d "$HOME/.config/wezterm" ]; then
    log_warn "~/.config/wezterm already exists. Backing up to ~/.config/wezterm.backup"
    mv "$HOME/.config/wezterm" "$HOME/.config/wezterm.backup.$(date +%s)"
  fi

  ln -sf "$REPO_ROOT/wezterm/.config/wezterm" "$HOME/.config/wezterm"
  log_info "Symlinked wezterm config"

  # Symlink background image
  if [ -f "$REPO_ROOT/img/dark-desert.jpg" ]; then
    ln -sf "$REPO_ROOT/img/dark-desert.jpg" "$HOME/.config/wezterm/dark-desert.jpg"
    log_info "Symlinked background image"
  fi

  log_info "WezTerm setup complete"
}

# =========================================================
# Starship Setup
# =========================================================

setup_starship() {
  log_info "Setting up Starship..."

  mkdir -p "$HOME/.config/starship"

  if [ -f "$REPO_ROOT/starship/starship.toml" ]; then
    ln -sf "$REPO_ROOT/starship/starship.toml" "$HOME/.config/starship/starship.toml"
    log_info "Symlinked starship.toml"
  else
    log_warn "starship.toml not found in repo"
  fi

  log_info "Starship setup complete"
}

# =========================================================
# Main Execution
# =========================================================

main() {
  echo "=========================================="
  echo "  Dotfiles Setup"
  echo "=========================================="
  echo

  check_prerequisites

  read -p "Install packages? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_packages
  fi

  setup_tmux
  setup_zsh
  setup_neovim
  setup_wezterm
  setup_starship

  echo
  echo "=========================================="
  log_info "Setup complete!"
  echo "=========================================="
  echo
  echo "Next steps:"
  echo "  1. Restart terminal or run: source ~/.zshrc"
  echo "  2. Launch nvim (plugins will auto-install on first run)"
  echo "  3. Launch wezterm (will auto-start tmux)"
  echo "  4. Edit ~/.config/zsh/local.zsh for machine-specific config"
  echo
  echo "Note: Zsh plugins will auto-install on first shell launch"
  echo
}

main "$@"
