# Path to your oh-my-zsh installation.
export ZSH="/Users/xbaysal11/.oh-my-zsh"

# =_=_=_= THEMES =_=_=_=
ZSH_THEME="robbyrussell"

# =_=_=_= ZSH CONFIG =_=_=_=
ENABLE_CORRECTION="true"
HIST_STAMPS="dd.mm.yyyy"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=241"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} '
 
# =_=_=_= PLUGINS =_=_=_=
plugins=(
  git
  sudo
  # managers
  brew
  npm
  yarn
  pip
  # js
  node
  gulp
  # another
  # zsh-syntax-highlighting
  fast-syntax-highlighting # [install] git clone https://github.com/zdharma/fast-syntax-highlighting.git \ ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
  zsh-autosuggestions # [install] git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

)

source $ZSH/oh-my-zsh.sh

# =_=_=_= ALIASES =_=_=_=

### Terminal config
alias poweroff='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias h="history"
alias hg="history | grep "
# alias ports="netstat -nlp"
# alias mc='~/.config/polybar/scripts/macCommand.sh'
alias wclone='wget --limit-rate=200k -nc -k --random-wait -r -p -E -e robots=off -U mozilla'
alias stowLink='stow --adopt -vt ~ *'
alias stowUnlink='stow -vDt ~ *'

### Config files

alias zshrc="vim ~/.zshrc"
alias i3c="vim ~/.config/i3/config"
alias s="speedtest --no-upload"

### Devices
alias ttl='sudo sysctl -w net.inet.ip.ttl=65;echo "TTL successfully changed to 65"'

### DNS
alias dns='cat /etc/resolv.conf'
alias dns-cloudflare='sudo sh -c "echo nameserver 1.1.1.1 > /etc/resolv.conf"; echo -e "DNS changed successfully!\n\nCLOUDFLARE (FAST)\n1.1.1.1"'
alias dns-yandex='sudo sh -c "echo nameserver 77.88.8.8 > /etc/resolv.conf"; echo -e "DNS changed successfully!\n\nYANDEX (FAST + STABLE)\n77.88.8.8"'
alias dns-google='sudo sh -c "echo nameserver 8.8.8.8 > /etc/resolv.conf"; echo -e "DNS changed successfully!\n\nGOOGLE (STABLE)\n8.8.8.8"'
alias dns-adguard1='sudo sh -c "echo nameserver 176.103.130.130 > /etc/resolv.conf"; echo -e "DNS changed successfully!\n\nADGUARD DEFAULT (adblock)\n176.103.130.130"'
alias dns-adguard2='sudo sh -c "echo nameserver 176.103.130.132 > /etc/resolv.conf"; echo -e "DNS changed successfully!\n\nADFUARD FAMILY (adblock + porn)\n176.103.130.132"'

### Git
alias ys="yarn start"
alias gI='git init'
alias gA="git add ."
alias gP="git push origin master"
alias gL="git pull origin master"
alias gC="git commit -m"
alias gCL="gcl"
alias gS="git status"
alias gac="git add .;git commit -m"
alias dt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

### SSH
alias sshpub='cat ~/.ssh/id_rsa.pub'
alias sshprv='cat ~/.ssh/id_rsa'

# PATH
export PATH=$PATH:~/.yarn/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

# EXA
if [ -n $(command -v exa) ]; then
  alias ls="exa --sort=ext --grid"
  alias la="exa -lah"
  alias l="exa -lah"
  alias ll="exa -lh"
fi

# NVIM
alias vim="nvim -u NORC"

# ALACRITTY
alias alacritty-colorscheme="alacritty-colorscheme -C ~/.alacritty_themes"
alias alacritty-colorscheme-dracula="alacritty-colorscheme -t dracula.yaml"
alias alacritty-colorscheme-gruvbox_dark="alacritty-colorscheme -t gruvbox_dark.yaml"
alias alacritty-colorscheme-gruvbox_light="alacritty-colorscheme -t gruvbox_light.yaml"
alias alacritty-colorscheme-solarized_light="alacritty-colorscheme -t solarized_light.yaml"

# BAT
export BAT_THEME="TwoDark"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_OPTS="--preview '(bat --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!.vscode/*" --glob "!node_modules/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# TMUX
alias tw='tmux a -t work'

# [ -z "$TMUX" ] && export TERM=xterm-256color && exec tmux a -t work