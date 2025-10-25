#!/bin/bash
set -euo pipefail
: "${URL:?Environment variable URL not set}"

LOGFILE="/workspace/setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "[INFO] Starting setup at $(date)"
mkdir -p /workspace
cd /workspace

echo "[INFO] Downloading entry script from: $URL"

curl -L \
  -H "Authorization: token $GH_PAT" \
  -H "Accept: application/vnd.github.v3.raw" \
  "https://api.github.com/repos/Alloterra/public/contents/entry.sh?ref=main" \
  -o entry.sh


echo "[INFO] Running entry.sh with current environment"
chmod +x /workspace/entry.sh
/workspace/entry.sh
# Run directly with bash, no chmod needed, environment preserved
#env -i bash -c 'export -p; source /workspace/entry.sh' || {
#  echo "[ERROR] entry.sh failed with code $?"; exit 1; }

echo "[INFO] entry.sh finished, waiting 300 seconds..."
echo "[INFO] Script completed at $(date)"
