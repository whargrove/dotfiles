# uv
fish_add_path "/Users/wes/.local/bin"
set -Ux EDITOR "zed --wait"

# pnpm
set -gx PNPM_HOME "/Users/wes/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/wes/google-cloud-sdk/path.fish.inc' ]; . '/Users/wes/google-cloud-sdk/path.fish.inc'; end

# starship
starship init fish | source

# direnv
direnv hook fish | source
