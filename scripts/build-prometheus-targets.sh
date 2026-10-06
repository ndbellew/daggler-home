#!/usr/bin/env bash
set -euo pipefail

TARGETS="${PROMETHEUS_NODE_TARGETS:?PROMETHEUS_NODE_TARGETS must be set}"

IFS=',' read -ra HOSTS <<< "$TARGETS"

{
  echo "- targets:"
  for host in "${HOSTS[@]}"; do
    echo "    - \"$host\""
  done
} > ./prometheus/targets.yaml