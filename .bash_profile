source ~/.bashrc
source ~/.git-prompt.sh

# Get all the bash completions
for f in /usr/local/etc/bash_completion.d/*; do
  source $f
done
