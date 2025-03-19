#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in */; do
  [ -f "$dir/Makefile" ] || continue
  echo "[-] Cleaning $dir"
  make -C "$dir" clean
done

