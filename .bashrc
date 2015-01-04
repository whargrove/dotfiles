export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR="bbedit"
export PATH=/usr/local/bin:/usr/local/Cellar/go/1.2.1/libexec/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH="$HOME/.rbenv/bin:$PATH"
export PS1='$(__git_ps1 "(%s)")\W$ '

if
	which rbenv > /dev/null;
	then eval "$(rbenv init -)";
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=1

alias "ll"="ls -la"
alias "l"="ls"
alias "speedtest"="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias "gs"="git status"
alias "gl"="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias "gb"="git branch"
alias "irb"="irb --simple-prompt"
alias "pry"="pry --simple-prompt"

# added by travis gem
[ -f /Users/wesley/.travis/travis.sh ] && source /Users/wesley/.travis/travis.sh

# Show all git branches (local and remote)
# optional: -v to trigger verbose output and show latest commit hash and commit message
gba () {
	option="${1}"
	case ${option} in
	-v)
		git branch -av
		;;
	*)
		git branch -a
		;;
	esac
}
