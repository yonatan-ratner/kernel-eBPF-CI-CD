#!/bin/bash
set -euo pipefail

echo "[DEBUG] Running build_kernel_docker.sh"
set -x

# Usage: ./build_kernel_docker.sh <base_image> <kernel_version>
BASE_IMAGE="${1:-ubuntu:22.04}"
KERNEL_VERSION="${2:-generic}"
ARCH="${3:-$(uname -m)}"

if [[ -z "${GITHUB_USER:-}" ]]; then
  echo "[ERROR] GITHUB_USER environment variable not set"
  exit 1
fi

# Sanitize base image name for use in tag
SAFE_TAG_OS=$(echo "$BASE_IMAGE" | tr ':/' '-' | tr '[:upper:]' '[:lower:]')
TAG="${SAFE_TAG_OS}-${KERNEL_VERSION}-${ARCH}"
IMAGE="ghcr.io/${GITHUB_USER}/kmod-builder:${TAG}"

echo "[INFO] Building kernel module builder image:" 
echo "   Base Image:      $BASE_IMAGE"
echo "   Kernel version:  $KERNEL_VERSION"
echo "   Image tag:       $IMAGE"
echo " ___________________________________________"

docker build \
  -t "$IMAGE" \
  --build-arg BASE_IMAGE="$BASE_IMAGE" \
  --build-arg KERNEL_VERSION="$KERNEL_VERSION" \
  -f "$(dirname "$0")/Dockerfile.kmod" \
  "$(git rev-parse --show-toplevel)" \

echo "✅ Image built: $IMAGE"
