### How to start

```bash
git clone --bare git@github.com:dmytro-afanasiev/.dotfiles.git .dotfiles
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
```

### Configuring tmux in Iterm2

There may be other better solutions but usually I just create a key binding that sends `0x02` hex code when 
user enters `Command+i`. That hex code means `Ctrl+b`.
