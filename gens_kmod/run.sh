#!/usr/bin/env bash

lsof -i TCP:6000 > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # You might just want to run this in another shell instead of bringing it up and down.
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
    SOCAT_PID=$!
fi

lsof -i TCP:6000 > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo 'Problem setting up a x11 display socket.'
    exit 1
fi

docker run \
    --rm \
    -t \
    --volume $(pwd):/root/project \
    scirelli/gens_kmod:latest "$@"

if [ ! -z "$SOCAT_PID" ]; then
    kill -15 $SOCAT_PID
fi
