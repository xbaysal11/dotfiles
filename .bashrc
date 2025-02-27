if [ -t 1 ]; then
  exec zsh
fi

/c/Windows/System32/chcp.com 65001 > /dev/null 2>&1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
