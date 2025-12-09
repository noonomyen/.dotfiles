if status is-interactive
    bind \cH backward-kill-path-component

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source

    # Aliases
    zoxide init fish | source

    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias cd="z"
    alias l="eza -alghHiMnOSmU --group-directories-first --git --icons --time-style=long-iso --color=always --hyperlink"
    alias ls="eza --group-directories-first --git --icons --time-style=long-iso --color=always --hyperlink"
    alias zed="zeditor"

    abbr -a -- - "cd -"
end
