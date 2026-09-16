# Environment variables configuration
set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
    # Set FZF default command to use fd (ignores gitignore, fast search)
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"

    # Dynamic FZF theme matching terminal palette (syncs with Caelestia)
    set -gx FZF_DEFAULT_OPTS "\
--color=bg:-1,bg+:-1,fg:white,fg+:bright-white \
--color=hl:blue,hl+:bright-blue \
--color=info:yellow,prompt:green,pointer:bright-cyan,marker:bright-yellow,spinner:blue \
--color=border:bright-black,header:blue \
--height 45% --layout=reverse --border=rounded --info=inline --margin=1 --padding=1 \
--prompt=' ' --pointer='' --marker=' ' \
--bind 'ctrl-backspace:backward-kill-word,ctrl-h:backward-kill-word,?:toggle-preview'"
end
