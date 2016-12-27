#!/bin/bash

BG_BLACK="$(tput setab 0)"
BG_RED="$(tput setab 1)"
BG_YELLOW="$(tput setab 3)"

declare -A maze maze0 paths
declare -a nextx nexty nextv
declare -a waypoints

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
      x) ;; # visited, do nothing
     \-) ;; # visited, do nothing
      .)
          maze["$x:$y"]="$v"
          add_point $x $y $v
          echo -n "$(tput cup $y $x)$v"
          ;;
      *)
          [[ $v == 'x' ]] && found_path $startv $m $((step))
          maze["$x:$y"]="$v"
          add_point $x $y '-'
  esac
}

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


draw_maze() {
  clear
  p=2

  for((y=0; y < ysize; y++)); do
    for((x=0; x < xsize; x++)); do
      v=${maze0["$x:$y"]}
      case "$v" in
         \#) echo -n "${BG_YELLOW} " ;;
          .) echo -n "${BG_BLACK} " ;;
      [0-9]) echo -n "${BG_RED}$v" ;;
      esac
    done
    echo
  done
}

# read maze
y=0
while read line ; do
  xsize=${#line}
  for((x=0; x < ${#line}; x++)); do
    v=${line:x:1}
    [[ $v == [0-9] ]] && waypoints[$v]="$x:$y"
    maze0["$x:$y"]=$v
  done
  ((y++))
done
ysize=$y

for ((startv=0; startv < ${#waypoints[@]}; startv++)); do
  for m in ${!maze0[@]}; do
    maze[$m]=${maze0[$m]}
  done

draw_maze
echo -n "$(tput cup 0 190)${BG_BLACK}start $startv"

startpoint=${waypoints[$startv]}
x=${startpoint%:*}
y=${startpoint#*:}
add_point $x $y "x"
maze["$x:$y"]="x"

# find shortest paths
for ((step=1; ${#nextx[@]} > 0; step++)); do
  echo -n "$(tput cup 1 190)${BG_BLACK}step $step"
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
done

clear
echo paths:
for path in ${!paths[@]}; do
  printf "%s %s\n" $path ${paths[$path]} | tr : ' '
done
