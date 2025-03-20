#!/bin/bash
set -e

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/$GITHUB_USER/ebpf-builder:latest \
  -f "$(dirname "$0")/Dockerfile.ebpf" \
  --push "$(git rev-parse --show-toplevel)"

