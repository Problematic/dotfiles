#!/bin/sh
# Battery icon / percentage for the Catppuccin status line.
#
# This replaces the tmux-battery plugin, which works by rewriting the
# status-right option after the fact -- that loses a race against Oh my tmux!'s
# _apply_important pass, leaving raw #{battery_icon} placeholders in the bar.
# Reading /sys directly from a #() job keeps everything at draw time instead.
#
# usage: battery.sh icon | battery.sh pct

bat=/sys/class/power_supply/BAT0
[ -r "$bat/capacity" ] || exit 0

capacity=$(cat "$bat/capacity")

case "$1" in
  pct)
    printf '%s%%' "$capacity"
    ;;
  icon)
    case "$(cat "$bat/status" 2>/dev/null)" in
      Charging)       printf '󰂄' ;;
      Full)           printf '󰚥' ;;
      'Not charging') printf '󱈑' ;;
      Discharging)
        # eight charge tiers, matching Catppuccin's @batt_icon_charge_tier*
        tier=$(( (capacity * 8 + 99) / 100 ))
        [ "$tier" -lt 1 ] && tier=1
        case "$tier" in
          1) printf '󰁺' ;; 2) printf '󰁻' ;; 3) printf '󰁼' ;; 4) printf '󰁽' ;;
          5) printf '󰁾' ;; 6) printf '󰁿' ;; 7) printf '󰂁' ;; *) printf '󰁹' ;;
        esac
        ;;
      *)              printf '󰂑' ;;
    esac
    ;;
esac
