#!/bin/bash
set -euo pipefail

# Usage: ./build_kernel_docker.sh <base_image> <kernel_version> <comma-seperated-platforms>
BASE_IMAGE="${1:-debian:bullseye}"
KERNEL_VERSION="${2:-$(uname -r)}"
PLATFORMS="${3:-linux/amd64}"

if [[ -z "${GITHUB_USER:-}" ]]; then
  echo "❌ GITHUB_USER environment variable not set"
  exit 1
fi

# Sanitize base image name for use in tag
SAFE_TAG_OS=$(echo "$BASE_IMAGE" | tr ':/' '-' | tr '[:upper:]' '[:lower:]')
TAG="${SAFE_TAG_OS}-${KERNEL_VERSION}"
IMAGE="ghcr.io/${GITHUB_USER}/kmod-builder:${TAG}"

echo "[INFO] Building kernel module builder image:" 
echo "   Base Image:      $BASE_IMAGE"
echo "   Kernel version:  $KERNEL_VERSION"
echo "   Platforms:       $PLATFORMS"
echo "   Image tag:       $IMAGE"
echo " ___________________________________________"

docker buildx build \
  --platform "$PLATFORMS" \
  -t "$IMAGE" \
  --build-arg BASE_IMAGE="$BASE_IMAGE" \
  --build-arg KERNEL_VERSION="$KERNEL_VERSION" \
  -f "$(dirname "$0")/Dockerfile.kmod" \
  "$(git rev-parse --show-toplevel)" \
  --push

echo "✅ Image built & pushed: $IMAGE"
