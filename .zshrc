export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"
export SCREENDIR="$HOME/.screen"
export FLYCTL_INSTALL="$HOME/.fly"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# History
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"
export HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# If a glob pattern doesn't match any files, expand it to nothing.
setopt nullglob

alias ls='eza -al'
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias ..='cd ..'
alias vi='nvim'
alias vim='nvim'
alias cat='bat'
alias screen='TERM=screen screen'
alias ports='sudo ss -lptn'
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'
alias update='sudo pacman -Syu'

psg() {
  ps -ef | grep -v grep | grep "$@"
}

getpid() {
  ps -ef | grep -v grep | grep "$1" | awk '{print $2}'
}

lspid() {
  ps -ef | grep -v grep | grep "$@" | awk '{ printf $2 " "; for (i = 8; i < NF; i++) printf $i " "; print $NF }'
}

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME/.git" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
autoload -Uz compinit && compinit
zinit cdreplay -q

# History search on arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ssh-agent bootstrap
SSH_ENV="$HOME/.ssh/agent-environment"

start_agent() {
  mkdir -p "$HOME/.ssh"
  ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" > /dev/null
}

if [ -f "$SSH_ENV" ]; then
  . "$SSH_ENV" > /dev/null
  ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null || start_agent
else
  start_agent
fi

for pubkey in "$HOME"/.ssh/{id_*,*.pem}; do
  if [ -f "$pubkey" ] && grep -q PRIVATE "$pubkey"; then
    ssh-add "$pubkey" 2>/dev/null
  fi
done

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  # Prefer mise shims so global npm: tools stay available across runtime switches.
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi
