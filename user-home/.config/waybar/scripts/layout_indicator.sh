#!/usr/bin/env bash

set -euo pipefail

FOCUSED_JSON=$(swaymsg -t get_tree)

# 取 representation 第一个字母
WS_NAME=$(echo "$FOCUSED_JSON" | jq -r '.nodes[] | select(.focused) | .name')
REPRESENTATION=$(echo "$FOCUSED_JSON" | jq -r --arg ws "$WS_NAME" '
  [.nodes[] | select(.name == $ws)][0].representation // ""
')
LAYOUT=$(echo "$REPRESENTATION" | head -c 1)
LAYOUT=${LAYOUT:-H}

# representation 为 null 时（单窗口），fallback 到父容器 layout
if [[ "$REPRESENTATION" == "" || "$REPRESENTATION" == "null" ]]; then
  LAYOUT=$(echo "$FOCUSED_JSON" | jq -r '
    [.. | objects | select(.focused == true and .app_id != null)][0] as $leaf |
    [.. | objects | select(.nodes[]? | select(.id == $leaf.id))][0].layout // "splith"
  ')
fi

case "$LAYOUT" in
  splith)   icon=" H"; class="layout-H" ;;
  splitv)   icon=" V"; class="layout-V" ;;
  tabbed)   icon=" T"; class="layout-T" ;;
  stacked)  icon=" S"; class="layout-S" ;;
  *)        icon=" $LAYOUT"; class="" ;;
esac

jq -c -n --arg text "$icon" --arg class "$class" '{text:$text, class:$class}'
