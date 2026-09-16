# Activate fzf.fish key bindings (patrickf1/fzf.fish plugin)
# Enables: Ctrl+R (history), Ctrl+Alt+F (files), Ctrl+Alt+L (git log),
#          Ctrl+Alt+S (git status), Ctrl+V (variables)
if status is-interactive
    and functions -q fzf_configure_bindings
    fzf_configure_bindings
end
