#!/bin/bash
#
# battery status script
# stolen from http://www.basicallytech.com/blog/index.php?/archives/110-Colour-coded-battery-charge-level-and-status-in-your-bash-prompt.html
# and modified
#

battery_state() {
  local battery=/proc/acpi/battery/BAT0
  grep "^charging state" $battery/state | awk '{ print $3 }'
}

battery_remaining() {
  local battery=/proc/acpi/battery/BAT0
  grep "^remaining capacity" $battery/state | awk '{ print $3 }'
}

battery_max() {
  local battery=/proc/acpi/battery/BAT0
  grep "^last full capacity" $battery/info | awk '{ print $4 }'
}

battery_percentage() {
  local remaining=$(battery_remaining)
  local full=$(battery_max)
  local state=$(battery_state)

  local percent_charged=`echo $(( $remaining * 100 / $full ))`

  # prevent a charge of more than 100% displaying
  [ "$percent_charged" -gt "99" ] && percent_charged=100

  echo $percent_charged
}

battery_state_indicator() {
  local percent_charged=$(battery_percentage)
  local state=$(battery_state)

  [ "$percent_charged" -gt "15" ] && local color="$c_yellow"
  [ "$percent_charged" -gt "30" ] && local color="$c_green"

  case "$state" in
    'charged')
    local state_indicator="x"
    ;;
    'charging')
    local state_indicator="+"
    ;;
    'discharging')
    local state_indicator="-"
    ;;
  esac

  echo $state_indicator
}
