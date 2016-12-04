#!/bin/bash

alphabet="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

while read line ; do
  if [[ "$line" =~ ^(.*)-([0-9]+)\[([a-z]+)\]$ ]]; then
    ROOM=${BASH_REMATCH[1]}
    SECTOR=${BASH_REMATCH[2]}
    echo "$ROOM: $SECTOR" | tr a-z ${alphabet:$((SECTOR % 26)):26}
  fi
done
