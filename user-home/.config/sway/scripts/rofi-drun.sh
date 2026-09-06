#!/bin/sh
# Author: BiaoZyx
# Email: BiaoZyx@outlook.com
# Date: 2026-08-26 19:56:05
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh

exec rofi -show drun -font 'JetBrainsMono Nerd Font Mono 12'
