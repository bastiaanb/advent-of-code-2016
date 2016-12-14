#!/bin/bash

INPUT=${1:-abc}

hashes=()
k=0
for ((i=0; ; i++)); do
  hash=$(echo -n "$INPUT$i" | md5sum | cut -f1 -d\  )
  hashes+=("$hash")
  m=$(grep -o -P '(.)(?=\1{4})' <<< $hash)
  if [ -n "$m" ] ; then
    echo found 5: $i $m $hash
    if [[ $i -lt 1000 ]]; then
      start=0
    else
      start=$((i - 1000))
    fi
    for((j=start; k < i; j++)); do
      if [[ ${hashes[j]} =~ $m$m$m ]]; then
        ((k++))
        echo "found 3 #$k @ $i ${hashes[j]}"
        [[ $k -eq 64 ]] && exit
        break
      fi
    done
  fi

done
