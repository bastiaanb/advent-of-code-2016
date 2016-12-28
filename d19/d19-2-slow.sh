#!/bin/bash

elfcount=$1

declare -a elfs

do_steps() {
  local q=$1
  local s=$2
  while [[ $s -gt 0 ]]; do
    ((q++, q %= elfcount ))
    if [[ ${elfs[$q]} -eq 1 ]]; then
      ((s--))
    fi
  done
  retval=$q
}

for((i=0;i < $elfcount; i++)); do
  elfs[$i]=1
done

n=0
r=0
for((i=$elfcount;i > 1; i--)); do
  # printf "%3d " $r
  # ((r++))
  # echo ${elfs[@]} | tr -d ' ' | tr '01' ' X'
  do_steps $n $((i/2))
  elfs[$retval]=0
  do_steps $n 1
  n=$retval
done

  # printf "%3d " $r
  # ((r++))
  # echo ${elfs[@]} | tr -d ' ' | tr '01' ' X'

for((i=0;i < $elfcount; i++)); do
  if [[ ${elfs[$i]} -eq 1 ]]; then
    echo "$i"
    break
  fi
done
