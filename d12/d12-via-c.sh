#!/bin/bash

OUT=/tmp/d12

{
  cat << EOF
#include <stdio.h>

int main(int argc, char **argv) {
  long a=0, b=0, c=0, d=0;

EOF

  pc=1
  while read instruction; do
    echo -n "L$pc: "
    if [[ "$instruction" =~ ^cpy\ ([a-d]|[0-9\-]+)\ ([a-d]) ]]; then
      echo "${BASH_REMATCH[2]}=${BASH_REMATCH[1]};"
    elif [[ "$instruction" =~ ^inc\ ([a-d]) ]]; then
      echo "${BASH_REMATCH[1]}++;"
    elif [[ "$instruction" =~ ^dec\ ([a-d]) ]]; then
      echo "${BASH_REMATCH[1]}--;"
    elif [[ "$instruction" =~ ^jnz\ ([a-d]|[0-9\-]+)\ ([0-9\-]+) ]]; then
      echo "if (${BASH_REMATCH[1]} != 0) goto L$((pc + ${BASH_REMATCH[2]}));"
    else
      echo "not matched: $instruction"
      exit 1
    fi
    ((pc++))
  done

  cat << EOF

  printf("%ld %ld %ld %ld\n", a, b, c, d);
}
EOF

} > $OUT.c

gcc -O3 -o $OUT $OUT.c
$OUT
