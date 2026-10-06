#!/usr/bin/env bash
set -euo pipefail

root_dir="$(pwd)"
script_dir="$root_dir/scripts"

cd $script_dir
bash bootstrap.sh
bash build-prometheus-targets.sh
cd $root_dir
docker compose up --build -d
cd $script_dir
bash configure-network.sh
cd $root_dir
docker compose logs -f --tail=20