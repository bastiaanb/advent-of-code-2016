#!/bin/bash

export LC_ALL=C

declare -a elfs

for((i=1; i <= $1; i++)); do
  elfs+=("$i")
done

start=0
while [[ ${#elfs[@]} -gt 1 ]]; do
  elfcount=${#elfs[@]}
  echo "elfs: $elfcount"
#  printf "%s\n" ${elfs[@]}
  declare -a nextelfs
  for((i=start; i < elfcount; i+=2)); do
    nextelfs+=("${elfs[$i]}")
  done
  ((start=(elfcount)%2))
  unset elfs
  declare -a elfs
  elfs=("${nextelfs[@]}")
  unset nextelfs
done

echo "winner: ${elfs[0]}"
