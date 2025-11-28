#!/bin/sh
echo toggle > /tmp/qs-dashboard.fifo
sleep 0.3
hyprpicker -a -f hex > /dev/null 2>&1 & 