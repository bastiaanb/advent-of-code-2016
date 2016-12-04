#!/bin/bash

total=0
while read line ; do
  if [[ "$line" =~ ^(.*)-([0-9]+)\[([a-z]+)\]$ ]]; then
    ROOM=${BASH_REMATCH[1]}
    SECTOR=${BASH_REMATCH[2]}
    SUM=${BASH_REMATCH[3]}
    if [[ "$ROOM" =~ ^([a-z]+)(-[a-z]+)*$ ]]; then
      CHECK=$(echo $(echo -n "$ROOM" | sed 's/\S/&\n/g' | grep -v -- '-' | sort | uniq -c | sort --key=1rn,1 --key=2,2 | head -5 | grep -o '.$') | sed 's/ //g')
      [[ $CHECK == $SUM ]] && ((total+=SECTOR))
    else
        echo "improper room $ROOM"
    fi
  else
    echo "improper line $line";
  fi
done
echo $total
