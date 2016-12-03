#!/bin/bash

((LX=0, LY=0))
((DY=1, DX=0))

declare -A trail
declare -A rot
rot=([L]=-1 [R]=1)

step=1
for i in $(sed 's/,//g'); do
  r=${i:0:1}
  l=${i:1}

  NDY=$((-1 * rot[$r] * $DX))
  DX=$((rot[$r] * $DY))
  DY=$NDY

  for s in $(seq 1 $l) ; do
    LX=$(($LX + $DX))
    LY=$(($LY + $DY))
    echo "x=$LX y=$LY"
    if [[ ${trail["$LX:$LY"]} -gt 0 ]] ; then
      echo visited $LX : $LY in step ${trail["$LX:$LY"]}
      echo $((${LX#-} + ${LY#-}))
      exit 0
    fi
    trail["$LX:$LY"]=$step
  done
  ((step++))
done
