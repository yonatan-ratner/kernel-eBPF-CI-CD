#!/bin/bash
set -e

cd "$(dirname "$0")"

for domain in */; do
  script="$domain/docker/build_${domain%/}_docker.sh"
  [ -x "$script" ] || continue

  echo "[+] Building docker image for $domain"
  "$script"
done

