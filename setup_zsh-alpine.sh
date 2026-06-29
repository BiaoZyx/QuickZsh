#!/usr/bin/env sh
# ============================================================
# Alpine Linux Zsh 安装脚本
# 基于通用脚本改造，专为 Alpine 优化
# 使用 apk 安装所有插件，无需克隆 GitHub
# ============================================================

set -e

# ============================================================
# 颜色定义
# ============================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================
# 运行时配置
# ============================================================
LOG_FILE="$HOME/.zsh_install_alpine_$(date +%Y%m%d_%H%M%S).log"

# ============================================================
# 日志函数
# ============================================================
log_info() {
    echo -e "${BLUE}[*] $1${NC}" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[✓] $1${NC}" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}[!] $1${NC}" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[✗] $1${NC}" | tee -a "$LOG_FILE"
}

# ============================================================
# 检查是否以 root 运行
# ============================================================
if [ "$(id -u)" -eq 0 ]; then
    log_error "请勿以 root 直接运行，使用普通用户 + doas"
    exit 1
fi

# ============================================================
# 安装 shadow（提供 chsh 命令）
# ============================================================
log_info "安装 shadow（chsh）..."
doas apk add shadow 2>&1 | tee -a "$LOG_FILE"

# ============================================================
# 安装 Zsh 和相关插件（通过 apk）
# ============================================================
log_info "安装 Zsh 和插件..."
doas apk add \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-history-substring-search \
    zsh-completions \
    zsh-theme-powerlevel10k \
    2>&1 | tee -a "$LOG_FILE"

# ============================================================
# 验证安装
# ============================================================
log_info "验证安装..."
if ! command -v zsh >/dev/null 2>&1; then
    log_error "Zsh 安装失败"
    exit 1
fi
log_success "Zsh 安装成功"

# ============================================================
# 备份现有 .zshrc
# ============================================================
if [ -f ~/.zshrc ]; then
    BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp ~/.zshrc "$BACKUP"
    log_info "已备份原 .zshrc 到 $BACKUP"
fi

# ============================================================
# 生成 Alpine 专用的 .zshrc
# ============================================================
log_info "生成 ~/.zshrc..."

cat > ~/.zshrc << 'EOF'
# ============================================================
# Zsh Configuration for Alpine Linux
# 基于 Alpine apk 插件路径
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
# Aliases (eza 优先)
# ------------------------------------------------------------
if command -v eza &> /dev/null; then
    export EZA_ICONS_AUTO=1
    alias ls='eza'
    alias ll='eza -l'
    alias la='eza -A'
    alias l='eza -lah'
else
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -lah'
fi
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
# Syntax Highlighting
# ------------------------------------------------------------
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ------------------------------------------------------------
# Autosuggestions
# ------------------------------------------------------------
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#787878"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# ------------------------------------------------------------
# History Substring Search
# ------------------------------------------------------------
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

    # 基础上下键
    bindkey '^[[A' up-line-or-history
    bindkey '^[[B' down-line-or-history
    bindkey '^[OA' up-line-or-history
    bindkey '^[OB' down-line-or-history
    bindkey '^R' history-incremental-search-backward

    # Alt+↑ / Alt+↓
    bindkey '^[[1;3A' history-substring-search-up
    bindkey '^[[1;3B' history-substring-search-down
fi

# ------------------------------------------------------------
# Powerlevel10k Theme (Alpine apk 路径)
# ------------------------------------------------------------
if [ -f /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
EOF

log_success ".zshrc 生成完成"

# ============================================================
# 设置 Zsh 为默认 Shell
# ============================================================
log_info "设置 Zsh 为默认 Shell..."
ZSH_PATH=$(command -v zsh)
if [ -n "$ZSH_PATH" ] && [ -f "$ZSH_PATH" ]; then
    if chsh -s "$ZSH_PATH" 2>/dev/null; then
        log_success "已设置 Zsh 为默认 Shell"
    else
        doas chsh -s "$ZSH_PATH" "$USER"
        log_success "已设置 Zsh 为默认 Shell（通过 doas）"
    fi
else
    log_error "Zsh 未安装或找不到"
    exit 1
fi

# ============================================================
# 完成
# ============================================================
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✅ 安装完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "运行 ${BLUE}zsh${NC} 立即体验，或注销重新登录。"
echo "Powerlevel10k 配置向导: ${BLUE}p10k configure${NC}"
echo "日志文件: ${BLUE}$LOG_FILE${NC}"
