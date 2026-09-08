export ZSH="$HOME/.oh-my-zsh"
plugins=(vi-mode pass dotenv aws)
source $ZSH/oh-my-zsh.sh


copy_to_clipboard() {
	if command -v pbcopy &>/dev/null; then
		echo -n "$1" | pbcopy
	elif command -v xclip &>/dev/null; then
		echo -n "$1" | xclip -selection clipboard
	elif command -v xsel &>/dev/null; then
		echo -n "$1" | xsel --clipboard --input
	elif command -v wl-copy &>/dev/null; then
		echo -n "$1" | wl-copy
	else
		return 1
	fi 
}

copy_git_branch() {
  local branch
  if ! branch="$(git branch --show-current 2>/dev/null)"; then
    return 1
  fi
  if [ -z "$branch" ]; then 
      branch="HEAD"
  fi

  if ! copy_to_clipboard "$branch"; then
    zle -M "Could not copy"
    return 1
  fi
  zle -M "$branch"
}
copy_git_commit() {
  local commit
  if ! commit="$(git rev-parse HEAD 2>/dev/null)"; then
    return 1
  fi
  if ! copy_to_clipboard "$commit"; then
    zle -M "Could not copy"
    return 1
  fi
  zle -M "$commit"
}

zle -N copy_git_branch
zle -N copy_git_commit
bindkey '^H' copy_git_branch
bindkey '^K' copy_git_commit

alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias vim=nvim
