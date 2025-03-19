#!/bin/bash
set -e

echo "[CI] Invoking modules/ global build"
modules/build_all.sh

