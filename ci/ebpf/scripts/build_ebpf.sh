#!/bin/bash
set -e

# Call the eBPF build via its Makefile, passing ARTIFACT_DIR
make -C modules/ebpf ARTIFACT_DIR=artifacts/ebpf

