#!/usr/bin/env bash

docker rmi $(docker images -f "dangling=true" -q)
docker build -t "scirelli/easy68k:latest" -t "scirelli/easy68k:v2.5.0" .
