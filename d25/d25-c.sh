#!/bin/bash

OUT=./d25

{
  cat << EOF
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=0, b=0, c=0, d=0, i=0, p=0;
  a=atol(argv[1]);

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
    elif [[ "$instruction" =~ ^tgl\ ([a-d]) ]]; then
      echo "printf(\"tgl %d\\n\", ${BASH_REMATCH[1]});"
    elif [[ "$instruction" =~ ^jnz\ ([a-d]|[0-9\-]+)\ ([0-9\-]+) ]]; then
      echo "if (${BASH_REMATCH[1]} != 0) goto L$((pc + ${BASH_REMATCH[2]}));"
    elif [[ "$instruction" =~ ^out\ ([a-d]) ]]; then
      cat << EOF
printf("%d", ${BASH_REMATCH[1]});
if (++i > 1) {
  if (b == p) {
    printf("\n");
    return 1;
  }
  if (i == 100000) {
    printf("\ncandidate\n");
    return 0;
  }
  p = b;
}
EOF
    else
      echo "not matched: $instruction"
      exit 1
    fi
    ((pc++))
  done

  cat << EOF
}
EOF

} > $OUT.c

gcc -O3 -o $OUT $OUT.c
for i in {1..1000000}; do echo -n "$i: " ; $OUT $i && break; done
echo $i
