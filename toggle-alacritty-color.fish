function toggle_alacritty_theme 
    pushd /Users/maurodelillo/.local/share/chezmoi/dot_config/alacritty
    grep "_dark" alacritty.yml
    if test $status -eq 0
        sed -i '' -e 's/gruvbox_dark.toml/gruvbox_light.toml/g' dot_config/alacritty/alacritty.toml
    else
        sed -i '' -e 's/gruvbox_light/gruvbox_dark/g' dot_config/alacritty/alacritty.toml
    end
