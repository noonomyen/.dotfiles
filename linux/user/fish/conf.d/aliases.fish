# Aliases and Abbreviations for interactive sessions
if status is-interactive
    # Command Aliases
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias cls="clear"
    alias cd="z"
    alias l="eza -alghHiMnOSmU -o --smart-group --group-directories-first --git --icons --time-style=long-iso --color=always --hyperlink"
    alias ls="eza --group-directories-first --git --icons --time-style=long-iso --color=always --hyperlink"
    alias lt="eza --grid --tree --icons --group-directories-first --color=always --hyperlink"

    # Abbreviations
    abbr -a -- - "cd -"
end
