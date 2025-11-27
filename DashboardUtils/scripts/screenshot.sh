#!/usr/bin/sh
echo "toggle" > /tmp/qs-dashboard.fifo # hide dashboard
sleep 0.3
tmp=$(mktemp)
grim -g "$(slurp)" $tmp  \
        && swappy -f $tmp

rm $tmp