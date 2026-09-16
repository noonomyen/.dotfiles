if status is-interactive
    # No greeting
    set fish_greeting

    # Initialize Prompt (Starship)
    starship init fish | source

    # Initialize smarter cd (Zoxide)
    zoxide init fish | source

    # Caelestia dynamic ANSI palette (OSC 4/10/11/12/17)
    cat ~/.local/state/caelestia/sequences.txt 2>/dev/null

end
