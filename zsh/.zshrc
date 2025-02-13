# Set up zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

## Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

## Completions
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

## Autosuggestions
zinit light zsh-users/zsh-autosuggestions

## fzf-tab
zinit light Aloxaf/fzf-tab

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls='eza -la'
alias v="nvim"
alias k="kubectl"
alias c="clear"
alias e="exit"
alias t="tmux"
alias sz="source ~/.zshrc"
alias vz="nvim ~/.zshrc"
alias dots="cd ~/dotfiles"
alias dls="cd ~/Downloads"
alias sb="nvim ~/Documents/Obsidian/second-brain"
alias setup="cd ~/setup"
alias godot="Godot"
alias repos="cd ~/workspace/github.com/jameskaupert"
alias obsidian="flatpak run md.obsidian.Obsidian"
alias path='echo -e ${PATH//:/\\n} | sort'
alias learn="cd ~/workspace/github.com/jameskaupert/always-be-learning"
alias website="cd ~/workspace/github.com/jameskaupert/personal-website"
alias windsurf="/usr/local/windsurf/windsurf"

# Functions
function ng() {
    local filename="${1:-.}" # set filename to . if no argument passed
    nvim --listen /tmp/godot.pipe "$filename"
}
# Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/opt/Postman/app"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/usr/local/bin/godot"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.tailwindcss"
export PATH="$PATH:$HOME/aseprite/build/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bat theme
export BAT_THEME="Nord"

# Nord dircolors
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

# Shell integrations
# Oh My Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/omp.toml)"

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi
source <(fzf --zsh)

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath+=~/.zfunc; autoload -Uz compinit; compinit

# K8s
source <(kubectl completion zsh)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/localuser/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
