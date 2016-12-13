#!/bin/bash

FAVNUM=1358
declare -A positions

put_at() {
  positions["$1:$2"]=$3
  echo -n "$(tput cup $2 $1)$3"
  sleep .02
}

is_open() {
  local n=$(( $1 * $1 + 3 * $1 + 2 * $1 * $2 + $2 + $2 * $2 + FAVNUM ))
  local parity
  for ((parity=0; n > 0; n >>=1)); do
    [[ $((n & 1)) -eq 1 ]] && ((parity=1-parity))
  done
  return $parity
}

try_position() {
  local x=$1
  local y=$2

  local state="${positions["$x:$y"]}"

  if [[ -z "${positions["$x:$y"]}" ]]; then
    if is_open $x $y; then
      put_at $x $y o
      nextx+=($x)
      nexty+=($y)
    else
      put_at $x $y "#"
    fi
  elif [[ $state == "@" ]]; then
    echo -n "$(tput cup 0 50)step $step: found target!"
    exit
  fi
}

clear
put_at 31 39 "@"

declare -a currentx currenty nextx nexty
nextx=(1)
nexty=(1)

for ((step=1; ; step++)); do
  echo -n "$(tput cup 0 50)step $step"
  currentx=("${nextx[@]}")
  currenty=("${nexty[@]}")
  nextx=()
  nexty=()
  for i in "${!currentx[@]}"; do
    cx="${currentx[$i]}"
    cy="${currenty[$i]}"
    [[ $cx -gt 0 ]] && try_position $((cx - 1)) $cy
    try_position $((cx + 1)) $cy
    [[ $cy -gt 0 ]] && try_position $cx $((cy - 1))
    try_position $cx $((cy + 1))
  done
done
