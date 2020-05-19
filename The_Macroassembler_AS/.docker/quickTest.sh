#!/usr/bin/env bash
apt-get update
cd /opt/
git clone https://github.com/0cjs/8bitdev.git
cd 8bitdev/
python3 -m venv --prompt 8bitdev ./.venv
.venv/bin/pip3 install --upgrade pip
.venv/bin/pip3 install -r requirements.txt
export BUILDDIR=`pwd`/build
.venv/bin/python3 ./tool/asl/Setup
