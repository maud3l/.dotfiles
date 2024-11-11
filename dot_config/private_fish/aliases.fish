
# General

alias ls=eza
alias c=chezmoi
alias ccd="chezmoi cd"
alias cai="chezmoi apply --interactive"
alias ca="chezmoi apply"
alias pubip="curl https://ipecho.net/plain ; echo"
alias copy=pbcopy
alias paste="pbpaste ; echo"
alias rg="rg --glob '!vendor' --glob '!go.mod' --glob '!go.sum' --max-columns=150 --max-columns-preview"
alias rrg="/opt/homebrew/bin/rg"
alias sd="cd ~ && cd (find * -type d | fzf)"
alias scd="cd (find * -type d | fzf)"
alias cdr="cd (git rev-parse --show-toplevel)"
# Editor
alias v=nvim
alias vim=nvim

# Kubernetes
alias k=kubectl
alias kgp="kubectl get pods"
alias kgpn="kubectl get pods --namespace"
alias kgpA="kubectl get pods --all-namespaces"
alias kga="kubectl get all"
alias kgan="kubectl get all --namespace"
alias kl="kubectl logs"
alias ksc="kubectl config set-context --current --namespace"
# Git
alias g="git"
alias ga="git add"
alias gA="git add ."
alias gap="git add --patch"
alias gcm="git commit -S -m"
alias gst="git status --short"
alias gp="git push origin (git branch --show-current)"
alias gll="git pull"
alias gd="git diff"
alias gdc="git diff --cached"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gbD="git branch -D"
alias gt="gitui"
alias gS="git stash"
alias gsi="git diff --name-only | fzf -m | xargs -I {} git stash push -m 'Stashing {}' -- {}"

#GitHub CLI
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"

#Do not commit
alias l=layer0
