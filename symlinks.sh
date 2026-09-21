# Define an array of symbolic link sources and targets
# NOTE: Run ./setup.sh instead for automated setup (includes dependencies, git submodules, etc.)

# Zsh
$(pwd)/zsh/.zshrc:$HOME/.zshrc
$(pwd)/zsh/.zshenv:$HOME/.zshenv
$(pwd)/zsh/aliases.zsh:$HOME/.config/zsh/aliases.zsh
$(pwd)/zsh/bindings.zsh:$HOME/.config/zsh/bindings.zsh
$(pwd)/zsh/fzf.zsh:$HOME/.config/zsh/fzf.zsh
$(pwd)/zsh/plugins.zsh:$HOME/.config/zsh/plugins.zsh
$(pwd)/zsh/prompt.zsh:$HOME/.config/zsh/prompt.zsh

# Starship
$(pwd)/starship/starship.toml:$HOME/.config/starship/starship.toml

# Tmux (requires gpakosz/.tmux framework cloned to ~/.tmux)
$(pwd)/tmux/gitmux.conf:$HOME/.tmux/gitmux.conf
# Note: tmux/.tmux.conf.local is copied (not symlinked) by setup.sh
$(pwd)/nvim:$HOME/.config/nvim
#$(pwd)/vim/.vimrc:$HOME/.vimrc
# $(pwd)/tmux/tmux.conf:$HOME/.config/tmux/tmux.conf
# $(pwd)/tmux/nord-theme.conf:$HOME/.config/tmux/nord-theme.conf
# $(pwd)/tmux/onedark-theme.conf:$HOME/.config/tmux/onedark-theme.conf
#$(pwd)/kitty:$HOME/.config/kitty
$(pwd)/wezterm:$HOME/.config/wezterm
$(pwd)/img/dark-desert.jpg:$HOME/.config/wezterm/dark-desert.jpg
#$(pwd)/vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json
#$(pwd)/vscode/keybindings.json:$HOME/Library/Application Support/Code/User/keybindings.json
#$(pwd)/dbeaver/.vrapperrc:$HOME/.vrapperrc
#$(pwd)/rectangle/RectangleConfig.json:$HOME/Library/Application Support/Rectangle/RectangleConfig.json
#$(pwd)/iterm/com.googlecode.iterm2.plist:$HOME/Library/Preferences/com.googlecode.iterm2.plist
#$(pwd)/iterm/Profiles.json:$HOME/Library/Application Support/iTerm2/DynamicProfiles/Profiles.json
#$(pwd)/karabiner/karabiner.json:$HOME/.config/karabiner/karabiner.json
#$(pwd)/ranger:$HOME/.config/ranger
