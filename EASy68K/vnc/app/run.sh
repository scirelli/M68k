#!/usr/bin/env bash
project=`pwd`

docker run \
    --name=easy68kv2-app \
    --detach \
    --restart=always \
    --volume=easy68kv2-data:/data \
    --volume="$project":/Projects \
    --net=easy68k-net \
    easy68kv2
