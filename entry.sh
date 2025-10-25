#!/bin/bash
set -euo pipefail
: "${URL:?Environment variable URL not set}"

LOGFILE="/workspace/setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "[INFO] Starting setup at $(date)"
mkdir -p /workspace
cd /workspace

echo "[INFO] Downloading entry script from: $URL"
if ! wget -q -O entry.sh "$URL"; then
  echo "[ERROR] wget failed for $URL"
  exit 1
fi

echo "[INFO] Running entry.sh with current environment"
# Run directly with bash, no chmod needed, environment preserved
env -i bash -c 'export -p; source /workspace/entry.sh' || {
  echo "[ERROR] entry.sh failed with code $?"; exit 1; }

echo "[INFO] entry.sh finished, waiting 300 seconds..."
echo "[INFO] Script completed at $(date)"
