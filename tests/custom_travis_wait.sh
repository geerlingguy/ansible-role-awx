#!/usr/bin/env bash
set -e
set -u

command=$1

# Launch command in the background.
${command} &

# Ping every second.
seconds=0
limit=45*60
while kill -0 $! >/dev/null 2>&1;
do
    echo -n -e " \b"
    if [ $seconds == $limit ]; then
        break;
    fi
    seconds=$((seconds + 1))
    sleep 1
done
