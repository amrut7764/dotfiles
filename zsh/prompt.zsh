# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

# Initialize starship prompt if installed
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  # Fallback to basic prompt
  PS1='%F{blue}%~%f %# '
fi