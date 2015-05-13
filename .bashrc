# node.js version manager
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR="subl"
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH="$HOME/.rbenv/bin:$PATH"
export PS1='$(__git_ps1 "(%s)")\W$ '

if
  which rbenv > /dev/null;
  then eval "$(rbenv init -)";
fi

GIT_PS1_SHOWDIRTYSTATE=1

# added by travis gem
[ -f /Users/wesley/.travis/travis.sh ] && source /Users/wesley/.travis/travis.sh

# Go stuff
export GOPATH = $HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

# Functions

# Show all files for current working directory
function ll {
  ls -al
}

# Show all visible files for current working directory
function l {
  ls
}

# Show pretty git log for repo in this dir
function gl {
  git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
}

# Show all git branches (local and remote)
# optional: -v to trigger verbose output and show latest commit hash and commit message
function gb () {
  option="${1}"
  case ${option} in
  -a)
    git branch -a
    ;;
  -v)
    git branch -v
    ;;
  -av)
    git branch -av
    ;;
  *)
    git branch
    ;;
  esac
}

# Show git status for current directory
function gs {
  git status
}

# Code
code() {
  if [[ $# = 0 ]]
  then
    open -a "Visual Studio Code"
  else
    [[ $1 = /* ]] && F="$1" || F="$PWD/$1#./"
    open -a "Visual Studio Code" --args "$F"
  fi
}
