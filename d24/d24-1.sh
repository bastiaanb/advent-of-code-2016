#!/bin/bash

declare -A maze paths
declare -a nextx nexty nextv

add_point() {
  nextx+=("$1")
  nexty+=("$2")
  nextv+=("$3")
}

try_position() {
  local x=$1
  local y=$2
  local v=$3
  local step=$4
  local m=${maze["$x:$y"]}

  case "$m" in
     \#) ;; # wall, do nothing
      .)
          maze["$x:$y"]="$v:$step"
          add_point $x $y $v
          echo -n "$(tput cup $y $x)$v"
          ;;
      *)
          ov=${m%:*}
          os=${m#*:}
          if [[ $ov != $v ]]; then
            found_path $v $ov $((step+os))
          fi
  esac
}

p=1
found_path() {
   if [[ $1 -lt $2 ]]; then
     path="$1:$2"
   else
     path="$2:$1"
   fi

   if [[ -z ${paths[$path]} ]]; then
     paths[$path]=$3
     echo -n "$(tput cup $p 190) $path $3"
     ((p++))
   fi
}

clear

# read maze
y=0
while read line ; do
  for((x=0; x < ${#line}; x++)); do
    v=${line:x:1}
    case "$v" in
       \#) echo -n "$(tput setab 3) $(tput setab 0)" ;;
        .) echo -n " " ;;
    [0-9]) echo -n "$(tput setab 1)$v$(tput setab 0)"
           add_point $x $y $v
           v+=":0"
           ;;
        *) echo "error: unknown char $v" && exit 1
    esac
    maze["$x:$y"]=$v
  done
  echo
  ((y++))
done

# find shortest paths
for ((step=1; ${#nextx[@]} > 0; step++)); do
  echo -n "$(tput cup 0 190)$(tput setab 0)step $step"
  currentx=("${nextx[@]}")
  currenty=("${nexty[@]}")
  currentv=("${nextv[@]}")
  nextx=()
  nexty=()
  nextv=()
  for i in "${!currentx[@]}"; do
    cx="${currentx[$i]}"
    cy="${currenty[$i]}"
    cv="${currentv[$i]}"
    try_position $((cx - 1)) $cy $cv $step
    try_position $((cx + 1)) $cy $cv $step
    try_position $cx $((cy - 1)) $cv $step
    try_position $cx $((cy + 1)) $cv $step
  done
done

for path in "${#paths[@]}"; do
  printf "%s: %s\n" $path ${paths}
