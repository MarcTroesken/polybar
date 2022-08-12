#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar i3 2>&1 | tee -a /tmp/polybar1.log & disown

EXTERNAL_MONITORS=$(polybar -m|grep -v eDP|cut -d : -f 1)
BAR_NUM=2
for MONITOR in $EXTERNAL_MONITORS; do
  MONITOR=$MONITOR polybar "i3-${BAR_NUM}" >>/tmp/polybar${BAR_NUM}.log 2>&1 &
  BAR_NUM=$((BAR_NUM+1))
done


echo "Bars launched..."
