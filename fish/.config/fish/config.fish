# uv
fish_add_path "$HOME/.local/bin"

set -gx EDITOR "zeditor --wait"

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME
# pnpm end

set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

# starship
#starship init fish | source

# direnv
direnv hook fish | source
