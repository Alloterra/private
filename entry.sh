#!/bin/bash
set -euo pipefail
: "${URL:?URL not set}"

mkdir -p /workspace
cd /workspace
wget -O entry.sh "$URL"
chmod u+x entry.sh
./entry.sh
