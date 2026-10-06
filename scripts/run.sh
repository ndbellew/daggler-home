#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

bash bootstrap.sh
bash scripts/build-prometheus-targets.sh

docker compose up --build -d

bash scripts/configure-network.sh

docker compose logs -f --tail=20