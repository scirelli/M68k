#!/usr/bin/env bash

docker build -t easy68kv2 .
docker network create easy68k-net
docker volume create easy68kv2-data
