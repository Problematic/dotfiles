# tmux runs a *login* shell per pane on top of the server's already-complete
# env, so ~/.zshrc and /etc/profile.d/emscripten.sh re-apply their unguarded
# PATH prepend/append. Set here (zshenv runs first) so it covers .zprofile too.
typeset -U path PATH

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
