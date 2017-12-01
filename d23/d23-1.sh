#!/bin/bash

readval() {
  case $1 in
    [abcd]) retval=${registers[$1]} ;;
    *) retval=$1
  esac
}

inc() {
  case $1 in
    [abcd]) ((registers[$1]++)) ;;
  esac
}

dec() {
  case $1 in
    [abcd]) ((registers[$1]--)) ;;
  esac
}

cpy() {
  case $2 in
    [abcd])
      readval $1
      registers[$2]=$retval
      ;;
  esac
}

jnz() {
  readval $1
  if [[ $retval -ne 0 ]]; then
    readval $2
    ((npc=pc+retval-1))
    if [[ $npc -ge 0 ]] && [[ $npc -lt $lines ]]; then
      pc=$npc
    fi
  fi
}

tgl() {
  readval $1
  echo tgl $retval
}

declare -A ins op1 op2

line=1
while read ins[$line] op1[$line] op2[$line]; do
  ((line++))
done
((lines=line - 1))

# for l in $(seq 1 $line); do
#   printf "%d: %s / %s / %s\n" $l ${ins[$l]} ${op1[$l]} ${op2[$l]}
# done

pc=1
declare -A registers
registers=([a]=0 [b]=0 [c]=0 [d]=0)

while [[ $pc -le $lines ]]; do
    printf  "%02d: %6d %6d %6d %6d    %s\n" "$pc" "${registers[a]}" "${registers[b]}" "${registers[c]}" "${registers[d]}" "${ins[$pc]} ${op1[$pc]} ${op2[$pc]}"
    ${ins[$pc]} ${op1[$pc]} ${op2[$pc]}
    ((pc++))
done
printf  "%02d: %6d %6d %6d %6d    %s\n" "$pc" "${registers[a]}" "${registers[b]}" "${registers[c]}" "${registers[d]}" "${ins[$pc]} ${op1[$pc]} ${op2[$pc]}"
