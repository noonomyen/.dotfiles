# Environment variables configuration
if status is-interactive
    # Set FZF default options (enables Ctrl+Backspace / Ctrl+H word deletion in FZF UI)
    set -gx FZF_DEFAULT_OPTS "--bind 'ctrl-backspace:backward-kill-word,ctrl-h:backward-kill-word'"
end
