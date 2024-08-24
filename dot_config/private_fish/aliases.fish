# General

alias ls=eza
alias c=chezmoi
alias ccd="chezmoi cd"
alias cai="chezmoi apply --interactive"
alias ca="chezmoi apply"
alias pubip="curl https://ipecho.net/plain ; echo"
alias copy=pbcopy
alias paste="pbpaste ; echo"
alias rg="rg --glob '!vendor' --glob '!go.mod' --glob '!go.sum' "
alias rrg="/opt/homebrew/bin/rg"

# Editor
alias v=nvim
alias vim=nvim

# Kubernetes
alias k=kubectl
alias kgp="kubectl get pods"
alias kgpn="kubectl get pods --namespace"
alias kgpA="kubectl get pods --all-namespaces"
alias kl="kubectl logs"

# Git
alias ga="git add"
alias gA="git add ."
alias gap="git add --patch"
alias gcm="git commit -m"
alias gst="git status --short"
alias gp="git push"
alias gll="git pull"
alias gd="git diff"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gbD="git branch -D"
alias gt="gitui"
alias gS="git stash"
