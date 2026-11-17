# ------------------------------------------------------------
# Environment Settings
# ------------------------------------------------------------
export PATH=/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.opencode/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Language
if [ $TERM = linux ]; then
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	export LANGUAGE=en_US:en
else
	export LANG=zh_CN.UTF-8
	export LC_ALL=zh_CN.UTF-8
	export LANGUAGE=zh_CN:zh
fi

export XDG_CURRENT_DESKTOP=sway

# Input Method
#export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# Qt Settings
export QT_QPA_PLATFORMTHEME=qt6ct

#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export QT_SCREEN_SCALE_FACTORS=1
#export QT_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1
export QT_FONT_DPI=90

# GTK Settings
export ADW_DISABLE_PORTAL=1


