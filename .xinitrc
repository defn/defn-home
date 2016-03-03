#!/usr/bin/env bash

export TERM='xterm-256color'
export PATH='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin' # TODO evaluate some more

cd
source ~/.bashrc

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
