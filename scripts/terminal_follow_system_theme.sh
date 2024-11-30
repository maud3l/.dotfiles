#!/bin/bash

theme=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

# Check if the current theme is already set correctly, to avoid unnecessary changes
current_light_theme=$(grep -E 'github_light.toml|github_light.fish' ~/.config/alacritty/alacritty.toml ~/.config/fish/config.fish)
current_dark_theme=$(grep -E 'github_dark.toml|github_dark.fish' ~/.config/alacritty/alacritty.toml ~/.config/fish/config.fish)

if [ "$theme" == "Dark" ]; then
    # Check if we need to switch to dark mode
    if [[ -z "$current_dark_theme" ]]; then
        # Alacritty
        sed -i '' 's/github_light.toml/github_dark.toml/g' ~/.config/alacritty/alacritty.toml
        # fish
        sed -i '' 's/github_light.fish/github_dark.fish/g' ~/.config/fish/config.fish
        # FZF
        echo 'set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:#848d97,bg:#0d1117,hl:#ffffff --color=fg+:#e6edf3,bg+:#111d2e,hl+:#ffa657 --color=info:#d29922,prompt:#2f81f7,pointer:#a371f7 --color=marker:#3fb950,spinner:#6e7681,header:#343941"' > ~/.config/fish/opts/fzf.fish
        # tmux
        tmux source-file ~/.config/tmux/themes/github_dark.conf
        source ~/.config/fish/opts/fzf.fish
    fi
else
    # Check if we need to switch to light mode
    if [[ -z "$current_light_theme" ]]; then
        # Alacritty
        sed -i '' 's/github_dark.toml/github_light.toml/g' ~/.config/alacritty/alacritty.toml
        # fish
        sed -i '' 's/github_dark.fish/github_light.fish/g' ~/.config/fish/config.fish
        # FZF
        echo 'set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:#656d76,bg:#ffffff,hl:#ffffff --color=fg+:#1F2328,bg+:#deeeff,hl+:#953800 --color=info:#9a6700,prompt:#0969da,pointer:#8250df --color=marker:#1a7f37,spinner:#24292f,header:#eff1f3"' >> ~/.config/fish/config.fish
        # tmux
        tmux source-file ~/.config/tmux/themes/github_light.conf
        source ~/.config/fish/opts/fzf.fish
    fi
fi
