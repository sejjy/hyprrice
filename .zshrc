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

# <<--< aliases >-->>

# shell
alias mkdir="mkdir -p"
alias c="clear"
alias e="exit"

# pacman
alias pfd="pacman -Ss"
alias pdl="sudo pacman -S"
alias prm="sudo pacman -Rns"

# yay
alias yfd="yay -Ss"
alias ydl="yay -S"
alias yrm="yay -Rns"

# nvim
alias conf="cd $HOME/.config && ls"
alias envim="cd $HOME/.config/nvim && nvim"
alias ewbar="cd $HOME/.config/waybar && nvim"

# misc
alias discord="discord --ozone-platform-hint=auto"
alias np="playerctl metadata --all-players --format '{{ title }} - {{ artist }}'"

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
  printf 'zsh: command not found: %s\n' "$1"
  local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  if (( ${#entries[@]} )) ; then
    printf "${bright}$1${reset} may be found in the following packages:\n"
    local pkg
    for entry in "${entries[@]}" ; do
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

# configure powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
