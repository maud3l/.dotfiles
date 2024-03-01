if status is-interactive
    # Commands to run in interactive sessions can go here
  # Disable greeting globally
  set -U fish_greeting
	fish_vi_key_bindings
	bind --mode insert --sets-mode default jj repaint

end
export $GOROOT/bin:$PATH
export GOPATH=/Users/maurodelillo/go

set -x EDITOR lvim

set PATH $GOPATH/bin /opt/homebrew/sbin /opt/homebrew/bin ~/.local/bin /usr/local/opt/python/libexec/bin /usr/local/bin /usr/local/sbin $PATH

bind \ce edit_command_buffer
bind --mode insert \ce edit_command_buffer

function __fish_set_oldpwd --on-variable dirprev
  set -g OLDPWD $dirprev[-1]
end

source ~/.config/fish/aliases.fish
source ~/.config/fish/functions/*.fish
