#!/usr/bin/env bash

docker rmi $(docker images -f "dangling=true" -q)
docker build -t "scirelli/gens_kmod:latest" -t "scirelli/gens_kmod:0.7.3" .
