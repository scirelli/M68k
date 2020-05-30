#!/usr/bin/env bash

docker rmi $(docker images -f "dangling=true" -q)
docker build -t "scirelli/asm68k:latest" -t "scirelli/asm68k:2.53" .
