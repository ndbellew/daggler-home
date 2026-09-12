#!/usr/bin/env bash
set -euo pipefail

DAGGLER_BASE="/var/lib/daggler-home"
DAGGLER_CONFIG="/etc/daggler-home"

DIRECTORIES=(
  "${DAGGLER_BASE}/caddy/data"
  "${DAGGLER_BASE}/caddy/config"
  "${DAGGLER_BASE}/pihole"
  "${DAGGLER_BASE}/portainer"

  "${DAGGLER_CONFIG}"
  "${DAGGLER_CONFIG}/secrets"
)

ensure_directory() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    echo "✓ $dir"
    return
  fi

  echo "+ Creating $dir"
  sudo mkdir -p "$dir"
}

ensure_file() {
  local file="$1"

  if [[ -f "$file" ]]; then
    echo "✓ $file"
    return
  fi

  echo "+ Creating $file"
  sudo touch "$file"
}

echo "Daggler Home bootstrap"
echo "======================"

for dir in "${DIRECTORIES[@]}"; do
  ensure_directory "$dir"
done

ensure_file "${DAGGLER_CONFIG}/secrets/pihole_admin_password"
ensure_file "${DAGGLER_CONFIG}/secrets/grafana_admin_password"

echo
echo "Bootstrap complete."