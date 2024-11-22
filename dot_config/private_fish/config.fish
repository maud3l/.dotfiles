
if status is-interactive
    # Commands to run in interactive sessions can go here
  # Disable greeting globally
  set -U fish_greeting
	fish_vi_key_bindings
	bind --mode insert --sets-mode default jj repaint
  atuin init fish | source
  eval "$(goenv init -)"
  set -x EDITOR nvim
  set -x GPG_TTY $(tty)
  set RIPGREP_CONFIG_PATH /Users/maurodelillo/.ripgreprc
  set -U fish_user_paths $fish_function_path $fish_user_paths
end

source ~/.config/fish/functions/*.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/completions/*
fzf --fish | source
pyenv init - | source

set PATH /opt/homebrew/sbin /opt/homebrew/bin ~/.local/bin /usr/local/opt/python/libexec/bin /usr/local/bin /usr/local/sbin $PATH
set PATH $GOROOT/bin $PATH
set PATH $PATH $GOPATH/bin
set -x GPG_TTY $(tty)
set RIPGREP_CONFIG_PATH /Users/maurodelillo/.ripgreprc

bind \ce edit_command_buffer
bind --mode insert \ce edit_command_buffer

function __fish_set_oldpwd --on-variable dirprev
  set -g OLDPWD $dirprev[-1]
end

set LAYER0_SPACE_SHELL_MAGIC true
