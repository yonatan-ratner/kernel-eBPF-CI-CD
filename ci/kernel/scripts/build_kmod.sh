#!/bin/bash
set -e

# Call the kernel build via its Makefile, passing in ARTIFACT_DIR
make -C modules/kernel ARTIFACT_DIR=artifacts/kernel

