#!/bin/bash
set -euo pipefail
cd /workspace
wget -O entry.sh $URL
chmod +x entry.sh
/workspace/entry.sh
