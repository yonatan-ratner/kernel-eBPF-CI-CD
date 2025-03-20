#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in */; do
  script="$dir/scripts/build_${dir%/}_docker.sh"
  [ -x "$script" ] || continue

  echo "[+] Building docker image for $dir"
  "$script"
done

