if [ -d "$HOME/.local/bin" ]; then
    export PATH=$PATH:$HOME/.local/bin
fi
alias vim='nvim'
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

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
	local branch=""

	if ! branch="$(git branch --show-current 2>/dev/null)"; then
		return 1
	fi
	if [ -z "$branch" ]; then
		branch='HEAD'
	fi
	if ! copy_to_clipboard "$branch"; then
		echo "Could not copy" >&2
		return 1
	fi
	echo "$branch"
}
copy_git_commit() {
	local commit=""
	if ! commit="$(git rev-parse HEAD 2>/dev/null)";then
		return 1
	fi
	if ! copy_to_clipboard "$commit"; then
		echo "Could not copy" >&2
		return 1
	fi
	echo "$commit"
}
bind -x '"\C-h": copy_git_branch'
bind -x '"\C-k": copy_git_commit'
