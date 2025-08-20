# 1Password SSH agent setup
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
if not test -S $SSH_AUTH_SOCK
    echo "Warning: 1Password SSH agent socket not found at $SSH_AUTH_SOCK"
end
