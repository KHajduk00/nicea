#!/bin/sh
echo toggle > /tmp/qs-dashboard.fifo
sleep 0.3
hyprctl dispatch exec steam