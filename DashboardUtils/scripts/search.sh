#!/usr/bin/sh
echo "toggle" > /tmp/qs-dashboard.fifo # hide dashboard
sleep 0.3
wofi --show drun