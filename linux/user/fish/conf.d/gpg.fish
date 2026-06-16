# GPG and SSH Agent configuration
set -gx GPG_TTY (tty)
set -e SSH_AGENT_PID
if not set -q gnupg_SSH_AUTH_SOCK_by
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

gpgconf --launch gpg-agent

if status is-interactive
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
