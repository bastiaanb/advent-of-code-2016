#!/bin/bash

declare -a used available used_sorted available_sorted

while read line; do
  if [[ $line =~ ^/dev/grid/([^\ ]+)\ +([0-9]+)T\ +([0-9]+)T\ +([0-9]+)T ]]; then
    dev=${BASH_REMATCH[1]}
    used+=("${BASH_REMATCH[3]} $dev")
    available+=("${BASH_REMATCH[4]} $dev")
  fi
done

used_sorted=($(printf "%s\n" "${used[@]}" | sort -n -r))
available_sorted=($(printf "%s\n" "${available[@]}" | sort -n -r))
pairs=0

for used_entry in "${used_sorted[@]}" ; do
  ud=${used_entry/ */}
  u=${used_entry/* /}
  if [[ $u -gt 0 ]]; then
    echo "ud: $ud u: $u"
    for avail_entry in "${available_sorted[@]}"; do
      ad=${avail_entry/ */}
      a=${avail_entry/* /}
      echo "   u: $u p: $pairs ad: $ad a: $a"
      if [[ $a -ge $u ]]; then
        [[ $ad == "$ud" ]] || ((pairs++))
      else
        break
      fi
    done
  fi
done

echo "PAIRS: $pairs"
