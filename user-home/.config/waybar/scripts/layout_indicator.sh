#!/usr/bin/env bash

set -euo pipefail

ws_name=$(swaymsg -t get_workspaces | jq -r '
  .[] | select(.focused == true) | .name
')

rep=$(swaymsg -t get_tree | jq -r --arg ws "$ws_name" '
  [.. | objects | select(.type == "workspace" and .name == $ws)] | .[0].representation // ""
')

layout=$(echo "$rep" | grep -oP '[A-Z](?=\[)' | tail -1 || true)
layout=${layout:-H}

case "$layout" in
  H)
    icon="H"
    class="layout-H"
    ;;
  V)
    icon="V"
    class="layout-V"
    ;;
  T)
    icon="T"
    class="layout-T"
    ;;
  S)
    icon="S"
    class="layout-S"
    ;;
  F)
    icon="F"
    class="layout-F"
    ;;
  D)
    icon="D"
    class="layout-D"
    ;;
  O)
    icon="O"
    class="layout-O"
    ;;
  *)
    icon="$layout"
    class=""
    ;;
esac

jq -c -n --arg text "$icon" --arg class "$class" \
  '{text:$text, class:$class}'
