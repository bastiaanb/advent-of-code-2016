#!/bin/bash

width=50
height=6

allspaces=$(printf "%$((width * height))s")
allhashes=${allspaces// /#}
display=${allspaces// /.}

print_display() {
  sed "s/.\{${width}\}/&\n/g" <<< $1
}

print_pixels() {
  tr -d '.\n' <<< $display | wc -c
}

rect() {
  echo "$(perl -p -e "s/(.{$2})(.{$(( width - $2 ))})/${allhashes:0:$2}\$2/g" <<< ${1:0:$((width * $3))})${1:$((width * $3))}"
}

rotate_row() {
  perl -p -e "s/^(.{$((width * $2 ))})(.{$((width - $3 ))})(.{$3})/\$1\$3\$2/" <<< $1
}

rotate_column() {
  perl -p -e "s/^\
$(for ((i=0; i < height; i++)); do echo -n "(.{$2})(.)(.{$(( width - $2 - 1 ))})"; done)\
/\
$(for ((i=0; i < height; i++)); do echo -n "\$$((1 + 3 * i))\$$(( (2 + 3 * (height + i - $3)) % (height * 3) ))\$$((3 + 3 * i))"; done)\
/" <<< $1
}

echo -n -e "\e[s"

sleep=${1:-0}
while read line ; do
  if [[ $line =~ ^rect\ ([0-9]+)x([0-9]+) ]]; then
    display=$(rect $display ${BASH_REMATCH[1]} ${BASH_REMATCH[2]})
  elif [[ $line =~ ^rotate\ row\ y=([0-9]+)\ by\ ([0-9]+) ]]; then
    display=$(rotate_row $display ${BASH_REMATCH[1]} ${BASH_REMATCH[2]})
  elif [[ $line =~ ^rotate\ column\ x=([0-9]+)\ by\ ([0-9]+) ]]; then
    display=$(rotate_column $display ${BASH_REMATCH[1]} ${BASH_REMATCH[2]})
  else
    echo unparsable line $line
    exit 1
  fi

  echo -n -e "\e[u"
  print_display $display
  sleep $sleep
done

print_pixels
