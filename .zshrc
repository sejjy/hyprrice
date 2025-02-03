# instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh"
fi

# options
setopt autocd
bindkey -e

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# completion
autoload -Uz compinit
compinit
zstyle :compinstall filename '/home/sejjy/.zshrc'

# theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# binds
bindkey "^[[C" autosuggest-accept
bindkey "\e[C" forward-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey '^H' backward-kill-word

# aliases
alias mkdir='mkdir -p'
alias np="playerctl metadata --all-players --format '{{ title }} - {{ artist }}'"

# configure powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
