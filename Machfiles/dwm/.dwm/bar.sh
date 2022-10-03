#!/bin/bash

# ~/.dwm/bar.sh
# 2021-01-24 00:43

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar --config="~/.dwm/config" example &

echo "Polybar launched..."
