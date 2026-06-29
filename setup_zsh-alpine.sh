#!/bin/sh
# ============================================================
# Alpine Linux Zsh 安装脚本
# 使用 apk 安装所有插件，无需克隆 GitHub 仓库
# ============================================================

set -e

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "${BLUE}========================================${NC}"
echo "${BLUE}Alpine Linux Zsh 安装脚本${NC}"
echo "${BLUE}========================================${NC}"

# 检查是否以 root 运行
if [ "$(id -u)" -eq 0 ]; then
    echo "${RED}请勿以 root 直接运行，使用普通用户 + doas${NC}"
    exit 1
fi

# 1. 安装 shadow（提供 chsh 命令）
echo "${YELLOW}[0/5] 安装 shadow（chsh）...${NC}"
doas apk add shadow

# 2. 安装 Zsh 和相关插件
echo "${YELLOW}[1/5] 安装 Zsh 和插件...${NC}"
doas apk add \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-history-substring-search \
    zsh-completions \
    zsh-theme-powerlevel10k

# 3. 检查安装是否成功
echo "${YELLOW}[2/5] 验证安装...${NC}"
if ! command -v zsh >/dev/null 2>&1; then
    echo "${RED}Zsh 安装失败${NC}"
    exit 1
fi

# 4. 生成 ~/.zshrc
echo "${YELLOW}[3/5] 生成 ~/.zshrc...${NC}"
if [ -f ~/.zshrc ]; then
    BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp ~/.zshrc "$BACKUP"
    echo "${YELLOW}已备份原 .zshrc 到 $BACKUP${NC}"
fi

cat > ~/.zshrc << 'EOF'
# ============================================================
# Zsh Configuration for Alpine Linux
# ============================================================

# ------------------------------------------------------------
# History
# ------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS

# ------------------------------------------------------------
# Navigation
# ------------------------------------------------------------
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS

# ------------------------------------------------------------
# Misc
# ------------------------------------------------------------
setopt EXTENDED_GLOB NO_CASE_GLOB INTERACTIVE_COMMENTS

# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias ip='ip --color=auto'

# ------------------------------------------------------------
# Completion
# ------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes

# ------------------------------------------------------------
# Plugins (Alpine apk paths)
# ------------------------------------------------------------
# Syntax Highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#787878"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# History Substring Search
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' up-line-or-history
    bindkey '^[[B' down-line-or-history
    bindkey '^R' history-incremental-search-backward
fi

# Powerlevel10k
if [ -f /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
EOF

# 5. 设置 Zsh 为默认 Shell（使用 shadow 提供的 chsh）
echo "${YELLOW}[4/5] 设置 Zsh 为默认 Shell...${NC}"
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    if chsh -s /usr/bin/zsh 2>/dev/null; then
        echo "${GREEN}已设置 Zsh 为默认 Shell${NC}"
    else
        echo "${YELLOW}需要密码来更改默认 Shell${NC}"
        doas chsh -s /usr/bin/zsh "$USER"
    fi
fi

echo "${GREEN}========================================${NC}"
echo "${GREEN}✅ 安装完成！${NC}"
echo "${GREEN}========================================${NC}"
echo ""
echo "下次登录时会自动进入 Zsh。"
echo "如果想立即体验，运行: ${BLUE}zsh${NC}"
echo ""
echo "首次进入 Zsh 时，Powerlevel10k 配置向导会自动启动。"
echo "如果未自动启动，运行: ${BLUE}p10k configure${NC}"
