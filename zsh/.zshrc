# if macOS, assume that Homebrew is installed
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# starship
eval "$(starship init zsh)"

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Use fzf for fuzzy searching
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###########
# HISTORY #
###########
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# Immediately append to history:
setopt INC_APPEND_HISTORY
# Record timestamp in history:
setopt EXTENDED_HISTORY
# Ignore duplicate entries first when trimming:
setopt HIST_EXPIRE_DUPS_FIRST
# Do not record an entry that was just recorded:
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previous found:
setopt HIST_FIND_NO_DUPS
# Do not record entry starting with a space:
setopt HIST_IGNORE_SPACE
# Do not write duplicate entries in history:
setopt HIST_SAVE_NO_DUPS
# Share history between all sessions:
setopt SHARE_HISTORY
# Execute commands using history (e.g.: using !$) immediately:
unsetopt HIST_VERIFY

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv >/dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Add ~/.local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# editor
export EDITOR="emacsclient -t"
alias e="emacsclient -t"

# Initialize sdkman
# https://sdkman.io/
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export SSH_AUTH_SOCK=~/.1password/agent.sock
