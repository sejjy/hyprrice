# instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# opts
setopt autocd
bindkey -e
ZLE_RPROMPT_INDENT=0

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# completion
autoload -Uz compinit
zstyle ':completion:*' rehash true
if [[ -n "$ZSH_COMPDUMP" && -f "$ZSH_COMPDUMP" ]]; then
  compinit -C  # use cache
else
  compinit
fi
zstyle :compinstall filename '/home/sejjy/.zshrc'

# <<--< plugins >-->>

# lazy-load zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# <<--< keybinds >-->>

bindkey "^[[C" autosuggest-accept
bindkey "\e[C" forward-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey '^H' backward-kill-word

# <<--< env >-->>

# replace man with batman (cached)
if [[ ! -f "$HOME/.cache/batman_env" ]]; then
  batman --export-env > "$HOME/.cache/batman_env"
fi
source "$HOME/.cache/batman_env"

export EDITOR=nvim

# <<--< aliases >-->>

# shell
alias reload="source ~/.zshrc"
alias mkdir="mkdir -p"
alias c="clear"
alias e="exit"
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="ls -lah --color=auto"

# pacman
alias pfd="pacman -Ss"
alias pup="sudo pacman -Syu"
alias pdl="sudo pacman -S"
alias prm="sudo pacman -Rns"

# yay
alias yfd="yay -Ss"
alias yup="yay -Syu"
alias ydl="yay -S"
alias yrm="yay -Rns"

# git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gcl="git clone"
alias grh="git reset HEAD"
alias gst="git stash"
alias gsta="git stash apply"

# nvim
alias nnvim="cd $HOME/.config/nvim && nvim"
alias nhypr="cd $HOME/.config/hypr && nvim"

# tmux
alias t="tmux"
alias tn="tmux new-session"
alias ta="tmux attach-session"
alias tls="tmux list-sessions"

# scripts
alias clean="$HOME/cleanup.sh"
alias server="$HOME/local-server.sh"

# misc
alias discord="discord --ozone-platform-hint=auto"
alias np="playerctl metadata --all-players --format '{{ title }} - {{ artist }}'"

# <<--< external >-->>

function command_not_found_handler {
  printf 'zsh: command not found: %s\n' "$1"
  if ! hash pacman 2>/dev/null; then return 127; fi
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  if (( ${#entries[@]} )); then
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf "${bright}$1${reset} may be found in the following packages:\n"
    local pkg
    for entry in "${entries[@]}"; do
      local fields=( ${(0)entry} )
      if [[ "$pkg" != "${fields[2]}" ]]; then
        printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
      fi
      printf '    /%s\n' "${fields[4]}"
      pkg="${fields[2]}"
    done
  fi
  return 127
}

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
