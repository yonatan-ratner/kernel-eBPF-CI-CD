#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in */; do
  [ -f "$dir/Makefile" ] || continue
  echo "[+] Building $dir"
  make -C "$dir"
done

