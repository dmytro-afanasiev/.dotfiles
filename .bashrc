if [ -d "$HOME/.local/bin" ]; then
    export PATH=$PATH:$HOME/.local/bin
fi
alias vim='nvim'
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
