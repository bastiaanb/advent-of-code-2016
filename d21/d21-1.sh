#!/bin/bash

move() {
  t="${input:0:$1}${input:$(($1 + 1))}"
  input="${t:0:$2}${input:$1:1}${t:$2}"
}

reverse() {
  input="${input:0:$1}$(echo -n ${input:$1:$(($2 + 1 - $1))} | rev)${input:$(($2 + 1))}"
}

find_letter() {
  for((i=0; i < ${#input}; i++)); do
    [[ ${input:$i:1} == $1 ]] && echo $i && return 0
  done

  echo letter $1 not found in $input
  exit 1
}

rotate_right() {
  i=$(($1 % ${#input}))
  if [[ $i -gt 0 ]]; then
    input="${input: -$i}${input:0: $((${#input} - $i))}"
  fi
}

rotate_left() {
  rotate_right $((${#input} - $1))
}

rots=(1 2 3 4 6 7 0 1)

rotate_letter() {
  i=$(find_letter $1)
  rotate_right ${rots[$i]}
}

swap_letter() {
  swap_position $(find_letter $1) $(find_letter $2)
}

swap_position() {
  if [[ $1 -lt $2 ]]; then
    a=$1
    b=$2
  else
    a=$2
    b=$1
  fi

  input="${input:0:$a}${input:$b:1}${input:$((a + 1)):$((b - a - 1))}${input:a:1}${input:$((b + 1))}"
}

input=$1
while read line; do
  if [[ $line =~ ^move\ position\ ([0-9]+)\ to\ position\ ([0-9]+) ]]; then
    move "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^reverse\ positions\ ([0-9]+)\ through\ ([0-9]+) ]]; then
    reverse "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^rotate\ based\ on\ position\ of\ letter\ ([a-z]) ]]; then
    rotate_letter "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^rotate\ left\ ([0-9]+)\ steps? ]]; then
    rotate_left "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^rotate\ right\ ([0-9]+)\ steps? ]]; then
    rotate_right "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^swap\ letter\ ([a-z])\ with\ letter\ ([a-z]) ]]; then
    swap_letter "${BASH_REMATCH[@]:1}"
  elif [[ $line =~ ^swap\ position\ ([0-9]+)\ with\ position\ ([0-9]+) ]]; then
    swap_position "${BASH_REMATCH[@]:1}"
  else
    echo "unrecognized line: $line"
    exit 1
  fi
  echo $input $line
done
