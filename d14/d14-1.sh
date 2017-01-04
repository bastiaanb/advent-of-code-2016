#!/bin/bash

INPUT=${1:-abc}
REPEATS=${2:-2017}

./d14 $INPUT $REPEATS | {
  declare -A found

  hashes=()
  found=()

  for ((i=0; ${#found[@]} < 80; i++)); do
    read hash
  #  [[ ${#hashes[@]} -ge 2000 ]] && hashes=("${hashes[@]:1000}")
    hashes+=("$hash")
    m=$(grep -o -P '(.)(?=\1{4})' <<< $hash)
    if [ -n "$m" ] ; then
      echo found 5: $i ${#hashes[@]} $m $hash
      start=$((${#hashes[@]} - 1000 - 1))
      [[ $start -lt 0 ]] && start=0
      for((j=start; j < ${#hashes[@]} - 1; j++)); do
        if [[ ${hashes[j]} =~ $m$m$m ]]; then
          found[$j]="$j ${hashes[j]}"
          echo "found 3 #${#found[@]} @ $j ${hashes[j]}"
        fi
      done
    fi
  done
  printf "%s\n" "${found[@]}" | sort -n
}
