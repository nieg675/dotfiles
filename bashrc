# EXPORTS

export EDITOR='nvim'
export VISUAL='nvim'

# ALIASES

alias k=kubectl
alias cdg='cd $(git rev-parse --show-toplevel)'
alias repos='cd /home/niels/repos'

# FUNCTIONS

function gitconfig() {
  if [ "$1" == "personal" ]; then
    ln -sf "$HOME/personal/.gitconfig.pers" "$HOME/git
}
