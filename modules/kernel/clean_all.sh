#!/bin/bash
set -e

# Resolve project root from git
# This COULD BECOME PROBLEMATIC when resolving paths if submodules are used
# since this dir may contain submodules as dirs, I think it's fine.
PROJECT_ROOT="$(git rev-parse --show-toplevel)"

# This will use the ARTIFACT_DIR which was passed down,
# or resort to a default path via PROJECT_ROOT
ARTIFACT_DIR="${ARTIFACT_DIR:-$PROJECT_ROOT/artifacts/kernel}"

cd "$(dirname "$0")"

for dir in */; do
    [ -f "$dir/Makefile" ] || continue
    echo "[+] Cleaning $dir"
    make -C "$dir" clean
done

rm -rf "$ARTIFACT_DIR"

