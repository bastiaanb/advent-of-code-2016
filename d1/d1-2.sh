#!/bin/bash

((LX=0, LY=0))
((DY=1, DX=0))

declare -A trail
declare -A rot
rot=([L]=-1 [R]=1)

step=1
earlieststep=1000000
hqdistance=1000000
for i in $(sed 's/,//g'); do
  r=${i:0:1}
  l=${i:1}

  (( tDY=-1 * rot[$r] * DX, DX=rot[$r] * DY, DY=tDY ))
  for s in $(seq 1 $l) ; do
    ((LX+=DX, LY+=DY))
    echo "x=$LX y=$LY"
    visited=${trail["$LX:$LY"]}
    if [[ $visited -gt 0 ]] ; then
      echo visited $LX : $LY in step $visited
      if [[ $visited -lt $earlieststep ]] ;then
        earlieststep=$visited
        hqdistance=$((${LX#-} + ${LY#-}))
      fi
    else
      trail["$LX:$LY"]=$step
    fi
  done
  ((step++))
done

echo hq is $hqdistance units away
