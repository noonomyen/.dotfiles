if status is-interactive
    # No greeting
    set fish_greeting

    # Initialize Prompt (Starship)
    starship init fish | source

    # Initialize smarter cd (Zoxide)
    zoxide init fish | source

end
