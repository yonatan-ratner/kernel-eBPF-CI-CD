#!/bin/bash
set -e

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/$GITHUB_USER/kmod-builder:latest \
  -f "$(dirname "$0")/Dockerfile.kmod" \
  --push "$(git rev-parse --show-toplevel)"

