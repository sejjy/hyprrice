# enable powerlevel10k instant prompt. should stay close to the top of ~/.zshrc.
# initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#----------------#
#	Parameters
#----------------#

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
ZLE_RPROMPT_INDENT=0

#-------------#
#	Options
#-------------#

setopt AUTO_CD
setopt GLOB_DOTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_BY_COPY
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt HASH_LIST_ALL
setopt CORRECT

#-------------#
#	Exports
#-------------#

export MANPAGER='nvim +Man!'
export FZF_DEFAULT_OPTS=" \
	--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
	--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
	--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
	--color=selected-bg:#45475A \
	--color=border:#6C7086,label:#CDD6F4"

#-------------#
#	Keymaps
#-------------#

bindkey -v # vi mode
bindkey '^ ' autosuggest-accept

#----------------#
#	Completion
#----------------#

autoload -Uz compinit
compinit

zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

#-------------#
#	Aliases
#-------------#

# file
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# list
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -alh'

# alt
alias find='fd'
alias grep='rg'
alias fd='fd --hidden --exclude timeshift'
alias fdf='fd --type file'
alias fdd='fd --type dir'

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
alias gcl='git clone'
alias gi='git init'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias grh='git reset --hard HEAD'
alias gcf='git clean -d --force'
alias gr='git restore'
alias gb='git branch'
alias gco='git checkout'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gl='git log --decorate --graph --oneline'
alias gd='git diff | bat'
alias gdh='git diff HEAD | bat'

# nvim
alias v='vim'
alias n='nvim'
alias nn="cd $HOME/.config/nvim && nvim"
alias nh="cd $HOME/.config/hypr && nvim"
alias nw="cd $HOME/.config/waybar && nvim"

# tmux
alias t='tmux'
alias tn='tmux new-session'
alias ta='tmux attach-session'
alias tls='tmux list-sessions'
alias tk='tmux kill-session'
alias tks='tmux kill-server'

# misc
alias np="playerctl metadata -af '{{ title }} - {{ artist }}'"
alias ytd="$HOME/.config/hypr/scripts/ytdlp.sh"
alias clean="$HOME/.config/hypr/scripts/cleanup.sh"
alias server="$HOME/.config/hypr/scripts/server.sh"
alias discord='discord --ozone-platform-hint=auto'
alias reload='exec zsh'

#-------------------------------------------#
#	pacman -F "command not found" handler
#	https://wiki.archlinux.org/title/Zsh
#-------------------------------------------#

function command_not_found_handler {
	printf 'zsh: command not found: %s\n' "$1"

	local entries=(
		${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
	)
	local purple='\e[1;35m'
	local bright='\e[0;1m'
	local green='\e[1;32m'
	local reset='\e[0m'

	if (( ${#entries[@]} )); then
		printf "${bright}$1${reset} may be found in the following packages:\n"
		local pkg

		for entry in "${entries[@]}"; do
			local fields=(${(0)entry})

			if [[ "$pkg" != "${fields[2]}" ]]; then
				printf "${purple}%s/${bright}%s ${green}%s${reset}\n" \
					"${fields[1]}" "${fields[2]}" "${fields[3]}"
			fi

			printf '\t/%s\n' "${fields[4]}"
			pkg="${fields[2]}"
		done
	fi
	return 127
}

#-------------#
#	Plugins
#-------------#

# Better vi mode
# https://github.com/jeffreytse/zsh-vi-mode
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

ZVM_CURSOR_STYLE_ENABLED=false

# Live suggestions
# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Prompt
# https://github.com/romkatv/powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
