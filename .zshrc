# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# Zsh Configuration File
# Generated: 2026-05-29 19:55:50
# ============================================================

# ------------------------------------------------------------
# History Configuration
# ------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# ------------------------------------------------------------
# Directory Navigation
# ------------------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# ------------------------------------------------------------
# Misc Options
# ------------------------------------------------------------
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt INTERACTIVE_COMMENTS

# ------------------------------------------------------------
# Key Bindings (Emacs mode)
# ------------------------------------------------------------
bindkey -e

bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^W' backward-kill-word
bindkey '^[d' kill-word

bindkey '^[[3~' delete-char
bindkey '^[[3;5~' kill-word

bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[OF' end-of-line

bindkey '^[[1;5D' backward-word
bindkey '^[^[[D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[^[[C' forward-word

# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------
if command -v eza &> /dev/null; then
    export EZA_ICONS_AUTO=1
    alias ls='eza'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -l'
alias la='ls -A'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias ip='ip --color=auto' 

# ------------------------------------------------------------
# Completion System
# ------------------------------------------------------------
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _ignored

# ------------------------------------------------------------
# Syntax Highlighting (MUST BE LAST)
# ------------------------------------------------------------
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------------------------------------------------------------
# Autosuggestions
# ------------------------------------------------------------
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#787878"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ------------------------------------------------------------
# History Substring Search
# ------------------------------------------------------------
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OA' up-line-or-history   # 兼容某些终端（如 Konsole）
bindkey '^[OB' down-line-or-history

bindkey '^R' history-incremental-search-backward # ^R

bindkey '^[[1;3A' history-substring-search-up    # Alt+Up
bindkey '^[[1;3B' history-substring-search-down  # Alt+Down

bindkey '^[[1;2A' up-history        # Shift+Up
bindkey '^[[1;2B' down-history      # Shift+Down

# ------------------------------------------------------------
# Powerlevel10k Theme
# ------------------------------------------------------------
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------
# Plugin Update Function
# ------------------------------------------------------------
update_zsh_plugins() {
    local failed=false
    for plugin in ~/.zsh/plugins/*; do
        if [ -d "$plugin/.git" ]; then
            echo "Updating $(basename $plugin)..."
            if ! git -C "$plugin" pull --rebase; then
                echo "  Failed to update $(basename $plugin)"
                failed=true
            fi
        fi
    done
    if [ "$failed" = true ]; then
        echo "Some plugins failed to update. Check your network."
    fi
}
