#!/usr/bin/env bash
hashp=`docker run --rm -it easy68kv2-caddy caddy hash-password -plaintext 'password'`

docker run \
    --name=easy68kv2-web \
    --detach \
    --restart=always \
    --volume=easy68kv2-data:/data \
    --net=easy68k-net \
    --env=APP_USERNAME="$USER" \
    --env=APP_PASSWORD_HASH="$hashp" \
    --publish=8080:8080 \
    easy68kv2-caddy
