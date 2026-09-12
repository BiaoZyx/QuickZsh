#!/bin/sh
#choice=$(printf "Lock\nLogout\nSleep\nReboot\nShutdown" | rofi -dmenu -p "Power")
choice=$(printf "Lock\nLogout\nSleep\nReboot\nShutdown" | fuzzel --dmenu -p "Power | ")

if [ -z "$choice" ]; then
  exit 0
fi

case "$choice" in
Lock) swaylock ;;
Logout) swaymsg exit ;;
Sleep)
  swaylock &
  loginctl suspend
  ;;
Reboot) dbus-run-session loginctl reboot ;;
Shutdown) dbus-run-session loginctl poweroff ;;
esac
