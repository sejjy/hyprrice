# =================
#  Prompt
# =================
# enable powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZLE_RPROMPT_INDENT=0 # remove right prompt indent

# =================
#  Configuration
# =================
# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt append_history    # append to HISTFILE
setopt extended_history  # save timestamp and duration
setopt hist_ignore_dups  # ignore duplicate commands
setopt hist_ignore_space # ignore commands starting with space
setopt share_history     # share history between sessions

# navigation
setopt auto_cd           # change directories without cd
setopt auto_pushd        # make cd push to directory stack
setopt pushd_ignore_dups # don't push duplicates to directory stack

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# load completion (use cache if available)
if [[ -n "${ZSH_COMPDUMP}" && -f "${ZSH_COMPDUMP}" ]]; then
  compinit -C
else
  compinit
fi

# =================
#  Key Bindings
# =================
bindkey -e # emacs key bindings

# custom key bindings
bindkey '^[[C' autosuggest-accept # right
bindkey "\e[C" forward-char       # left
bindkey '^[[1;5D' backward-word   # ctrl + left
bindkey '^[[1;5C' forward-word    # ctrl + right
bindkey '^H' backward-kill-word   # ctrl + backspace

# =================
#  Environment
# =================
export EDITOR='nvim'
export VISUAL='nvim'

# batman
if command -v batman &>/dev/null; then
  if [[ ! -f "${HOME}/.cache/batman_env" ]]; then
    batman --export-env > "${HOME}/.cache/batman_env"
  fi
  source "${HOME}/.cache/batman_env"
fi

# =================
#  Plugins
# =================
# autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =================
#  Aliases
# =================
# general
alias c='clear'
alias e='exit'
alias rel='exec zsh' # source ~/.zshrc
alias mkdir='mkdir -p'
alias rm='rm -i'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -alh'
alias grep='grep --color=auto'
alias fd='fd --hidden --exclude timeshift'
alias fdf='fd --type f'
alias fdd='fd --type d'

# pacman
alias pup='sudo pacman -Syu'
alias pfd='pacman -Ss'
alias pdl='sudo pacman -S'
alias prm='sudo pacman -Rns'
alias pls='pacman -Q'

# AUR
alias yup='yay -Syu'
alias yfd='yay -Ss'
alias ydl='yay -S'
alias yrm='yay -Rns'
alias yls='yay -Qm'

# git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff | bat'
alias gl='git log --oneline --graph --decorate'
alias gr='git restore'
alias gdh='git diff HEAD | bat'
alias gcl='git clone'
alias grh='git reset HEAD'
alias gst='git stash'
alias gsta='git stash apply'

# nvim
alias v='vim'
alias n='nvim'
alias nn="cd $HOME/.config/nvim && nvim"
alias nh="cd $HOME/.config/hypr && nvim"
alias nw="cd $HOME/.config/waybar && nvim"

# docker
alias d='docker'
alias dr='docker run'
alias dp='docker ps'
alias dpa='docker ps --all'
alias dim='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias ds='docker start'
alias dst='docker stop'
alias dso='docker start open-webui'
alias dsto='docker stop open-webui'

# ollama
alias o='ollama'
alias oc='ollama create'
alias ol='ollama list'
alias op='ollama ps'
alias orm='ollama rm'
alias or='ollama run'
alias os='ollama stop'
alias ord='ollama run deepseek-r1:1.5b'
alias orq='ollama run qwen2.5-coder:3b'
alias osd='ollama stop deepseek-r1:1.5b'
alias osq='ollama stop qwen2.5-coder:3b'

# =================
#  Custom
# =================
function command_not_found_handler {
  printf "zsh: command not found: %s\n" "$1"
  if ! hash pacman 2>/dev/null; then return 127; fi
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  if (( ${#entries[@]} )); then
    local purple="\e[1;35m" bright="\e[0;1m" green="\e[1;32m" reset="\e[0m"
    printf "${bright}$1${reset} may be found in the following packages:\n"
    local pkg
    for entry in "${entries[@]}"; do
      local fields=( ${(0)entry} )
      if [[ "$pkg" != "${fields[2]}" ]]; then
        printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
      fi
      printf "    /%s\n" "${fields[4]}"
      pkg="${fields[2]}"
    done
  fi
  return 127
}

# =================
#  Local
# =================
alias np="playerctl metadata --all-players --format '{{ title }} - {{ artist }}'"
alias ytd="${HOME}/.config/hypr/scripts/yt_dlp.sh"
alias clean="${HOME}/.config/hypr/scripts/cleanup.sh"
alias server="${HOME}/.config/hypr/scripts/local_server.sh"
alias discord="discord --ozone-platform-hint=auto"
