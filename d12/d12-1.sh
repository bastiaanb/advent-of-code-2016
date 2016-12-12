#!/bin/bash

readval() {
  if [[ "$1" =~ ^[a-d] ]]; then
    val=${registers[$1]}
  else
    val=$1
  fi
}

declare -a program
declare -A registers
registers=([a]=0 [b]=0 [c]=0 [d]=0)

while read line; do
  program+=("$line")
done

pc=0
while [[ pc -lt ${#program[@]} ]]; do
  instruction="${program[$pc]}"
  printf  "%02d: %6d %6d %6d %6d    %s\n" "$pc" "${registers[a]}" "${registers[b]}" "${registers[c]}" "${registers[d]}" "$instruction"
  if [[ "$instruction" =~ ^cpy\ ([a-d]|[0-9\-]+)\ ([a-d]) ]]; then
    reg=${BASH_REMATCH[2]}
    readval ${BASH_REMATCH[1]}
    registers[$reg]=$val
  elif [[ "$instruction" =~ ^inc\ ([a-d]) ]]; then
    ((registers[${BASH_REMATCH[1]}]++))
  elif [[ "$instruction" =~ ^dec\ ([a-d]) ]]; then
    ((registers[${BASH_REMATCH[1]}]--))
  elif [[ "$instruction" =~ ^jnz\ ([a-d]|[0-9\-]+)\ ([0-9\-]+) ]]; then
    step=${BASH_REMATCH[2]}
    readval ${BASH_REMATCH[1]}
    if [[ $val -ne 0 ]]; then
      ((pc+=step - 1))
    fi
  else
    echo "not matched: $instruction"
    exit 1
  fi
  ((pc++))
done

printf  "%02d: %6d %6d %6d %6d\n" "$pc" "${registers[a]}" "${registers[b]}" "${registers[c]}" "${registers[d]}"
