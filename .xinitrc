#!/bin/bash

cd

xsetroot -solid '#000000'
xrdb -merge .Xresources
xmodmap .Xmodmap

xset b 0
xset r rate 250 60

if [[ -x ~/Library/Haskell/bin/xmonad ]]; then
  xterm -ls +sb -fb fixed &
  xterm -ls +sb -fb fixed &
  exec ~/Library/Haskell/bin/xmonad
else
  exec xterm -ls +sb -fb fixed
fi
