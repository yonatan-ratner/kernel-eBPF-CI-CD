#!/bin/bash
set -e

cd modules/kernel/
make

mkdir -p /artifacts
cp *.ko /artifacts/

