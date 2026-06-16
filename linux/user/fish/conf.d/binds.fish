# Key bindings for fish shell, including natural-selection
function fish_user_key_bindings
    # Custom backspace behavior
    bind \cH '_natural_selection backward-kill-path-component'
    bind ctrl-backspace '_natural_selection backward-kill-path-component'

    # natural-selection bindings
    if functions -q _natural_selection
        bind escape            '_natural_selection end-selection'

        bind ctrl-r            '_natural_selection history-pager'

        bind up                '_natural_selection up-or-search'
        bind down              '_natural_selection down-or-search'
        bind left              '_natural_selection backward-char'
        bind right             '_natural_selection forward-char'

        # Shift + Arrow Keys (Select Character/Line)
        bind shift-left        '_natural_selection backward-char --is-selecting'
        bind shift-right       '_natural_selection forward-char --is-selecting'
        bind shift-up          '_natural_selection up-line --is-selecting'
        bind shift-down        '_natural_selection down-line --is-selecting'

        # Ctrl + Shift + Arrow Keys (Select Word)
        bind ctrl-shift-left   '_natural_selection backward-word --is-selecting'
        bind ctrl-shift-right  '_natural_selection forward-word --is-selecting'

        # Ctrl + Arrow Keys (Normal Word Movement)
        bind ctrl-left         '_natural_selection backward-word'
        bind ctrl-right        '_natural_selection forward-word'

        # Home/End, Ctrl+Alt+Left/Right and Shift + Home/End
        bind home              '_natural_selection beginning-of-line'
        bind end               '_natural_selection end-of-line'
        bind ctrl-alt-left     '_natural_selection beginning-of-line'
        bind ctrl-alt-right    '_natural_selection end-of-line'

        bind shift-home        '_natural_selection beginning-of-line --is-selecting'
        bind shift-end         '_natural_selection end-of-line --is-selecting'

        # Delete/Backspace behavior with selection
        bind delete            '_natural_selection delete-char'
        bind backspace         '_natural_selection backward-delete-char'

        # Text replacement when typing over selection
        bind ''                kill-selection end-selection self-insert
    end
end
