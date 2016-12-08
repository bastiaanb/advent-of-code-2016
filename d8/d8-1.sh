#!/bin/bash

width=50
height=6

display=$(yes . | head -$(( width * height)) | tr -d '\n')
allhash=$(tr '.' '#' <<< $display)

print_display() {
  sed "s/.\{${width}\}/&\n/g" <<< $1
}

print_pixels() {
  echo $display | tr -d '.' | tr -d '\n' | wc -c
}

rect() {
  echo "$(perl -p -e "s/(.{$2})(.{$(( width - $2 ))})/${allhash:0:$2}\$2/g" <<< ${1:0:$((width * $3))})${1:$((width * $3))}"
}

rotate_row() {
  perl -p -e "s/^(.{$((width * $2 ))})(.{$((width - $3 ))})(.{$3})/\$1\$3\$2/" <<< $1
}

rotate_column() {
  perl -p -e "s/^\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
(.{$2})(.)(.{$(( width - $2 - 1 ))})\
/\
\$1\$$(( (18 + 2 - 3 * $3) % 18 ))\$3\
\$4\$$(( (18 + 5 - 3 * $3) % 18 ))\$6\
\$7\$$(( (18 + 8 - 3 * $3) % 18 ))\$9\
\$10\$$(( (18 + 11 - 3 * $3) % 18 ))\$12\
\$13\$$(( (18 + 14 - 3 * $3) % 18 ))\$15\
\$16\$$(( (18 + 17 - 3 * $3) % 18 ))\$18\
/" <<< $1
}

echo -n -e "\e[s"

sleep=${1:-0}
while read line ; do
#  echo $line
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
