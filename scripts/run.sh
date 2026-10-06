#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${ROOT_DIR}"

bash bootstrap.sh
bash scripts/build-prometheus-targets.sh

docker compose up --build -d

bash scripts/configure-network.sh

docker compose logs -f --tail=20