#!/bin/bash

declare -a val low hi

# 1: bot
# 2: low type
# 3: low nr
# 4: hi type
# 5: hi nr
add_bot() {
  if [[ $2 == "bot" ]]; then
    low[$1]=$3
  else
    low[$1]="O$3"
  fi
  if [[ $4 == "bot" ]]; then
    hi[$1]=$5
  else
    hi[$1]="O$5"
  fi
}

# 1: value
# 2: bot
add_input() {
  local l
  local h
  if [[ ${val[$2]} == "" ]]; then
    val[$2]=$1
  else
    if [[ ${val[$2]} -lt $1 ]]; then
      l=${val[$2]}
      h=$1
    else
      l=$1
      h=${val[$2]}
    fi
    if [[ $l -eq 17 ]] && [[ $h -eq 61 ]]; then
      echo "found right bot: $2"
    fi
    val[$2]=""
    fire_out $l ${low[$2]}
    fire_out $h ${hi[$2]}
  fi
}

# 1: value
# 2: dest
fire_out() {
  if [[ $2 != "" ]]; then
    if [[ ${2:0:1} == "O" ]]; then
      echo "output ${2:1} received $1"
    else
      add_input $1 $2
    fi
  else
    echo "value $1 dropped: no dest"
    exit
  fi
}

sort | {
  while read line ; do
    if [[ $line =~ ^bot\ ([0-9]+)\ gives\ low\ to\ (bot|output)\ ([0-9]+)\ and\ high\ to\ (bot|output)\ ([0-9]+) ]]; then
      add_bot "${BASH_REMATCH[@]:1}"
    elif [[ $line =~ ^value\ ([0-9]+)\ goes\ to\ bot\ ([0-9]+) ]]; then
      add_input "${BASH_REMATCH[@]:1}" file
    else
      echo "unrecognized line $line"
      exit 1
    fi
  done
}
