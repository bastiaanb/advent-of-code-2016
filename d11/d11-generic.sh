#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "invoke as $0 <# items floor 1> <# items floor 2> ..."
  exit 1
fi

for i in $(seq 1 $#); do
  ((items+=${!i}, steps+= (items-1)*2 - 1))
done

echo $steps
