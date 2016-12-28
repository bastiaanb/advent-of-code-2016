#!/bin/bash

part=${1:-1}

declare -A nodes paths
declare -a current next

while read from to length; do
  nodes[$from]=1
  nodes[$to]=1
  paths["$from:$to"]=$length
  paths["$to:$from"]=$length
done

next+=("0:1:0")
shortestpath=""
shortestlength=1000000

while [[ ${#next[@]} -gt 0 ]]; do
  printf "%s\n" "${next[@]}"
  echo
  current=("${next[@]}")
  next=()
  for c in ${current[@]}; do
    currentpath=${c%%:*}
    from=${currentpath: -1}
    currentvisited=${c%:*}
    currentvisited=${currentvisited#*:}
    currentlength=${c##*:}
    for to in ${!nodes[@]}; do
      if [[ $from != "$to" ]]; then
        p=${paths["$from:$to"]}
        if [[ -n $p ]]; then
          nextpath="${currentpath}$to"
          nextlength=$((currentlength + p))
          if [[ $currentpath == *$to* ]]; then
            nextvisited=$currentvisited
          else
            nextvisited=$((currentvisited+1))
          fi
          if [[ $nextlength -lt $shortestlength ]]; then
            if [[ $nextvisited -eq ${#nodes[@]} ]] && ([[ $part -eq 1 ]] || [[ $to -eq 0 ]]) ; then
              echo "found path $nextpath length $nextlength"
              shortestlength=$nextlength
              shortestpath=$nextpath
            else
              next+=("${nextpath}:${nextvisited}:${nextlength}")
            fi
          fi
        fi
      fi
    done
  done
done

echo "shortest path $shortestpath length $shortestlength"
