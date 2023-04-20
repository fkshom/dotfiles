[[ $SSH_AUTH_SOCK != $HOME/.ssh/sock && -S $SSH_AUTH_SOCK ]] \
    && ln -snf "$SSH_AUTH_SOCK" "$HOME/.ssh/sock" \
    && export SSH_AUTH_SOCK="$HOME/.ssh/sock"

