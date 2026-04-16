
# XDG Base directory specification
export XDG_CONFIG_HOME="$HOME/.config"         # Config files
export XDG_CACHE_HOME="$HOME/.cache"           # Cache files
export XDG_DATA_HOME="$HOME/.local/share"      # Application data
export XDG_STATE_HOME="$HOME/.local/state"     # Logs and state files

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# Use Neovim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Add /usr/local/bin to the beginning of the PATH environment variable.
# This ensures that executables in /usr/local/bin are found before other directories in the PATH.
export PATH="/usr/local/bin:$PATH"

# Set LDFLAGS environment variable for the linker to use the specified directories for library files.
# This is useful when building software that depends on non-standard library locations, like zlib and bzip2 in this case.
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"

# Set CPPFLAGS environment variable for the C/C++ preprocessor to use the specified directories for header files.
# This is useful when building software that depends on non-standard header locations, like zlib and bzip2 in this case.
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# Hide computer name in terminal
export DEFAULT_USER="$(whoami)"
# >>> Claude Code Configuration >>>
# Added by Claude Code installer - Do not edit this block manually
export AWS_PROFILE="bedrock"
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION="us-east-1"
export ANTHROPIC_MODEL="us.anthropic.claude-sonnet-4-5-20250929-v1:0"
export ANTHROPIC_SMALL_FAST_MODEL="us.anthropic.claude-haiku-4-5-20251001-v1:0"
# <<< Claude Code Configuration <<<
