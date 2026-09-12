#!/usr/bin/env bash
set -euo pipefail

DAGGLER_IP="${DAGGLER_LAN_IP:-192.168.4.23}"
DAGGLER_DOMAIN="${DAGGLER_DOMAIN:-daggler.home.arpa}"

echo "Daggler Home network setup"
echo "=========================="

echo
echo "Checking Pi-hole DNS..."

if dig @"${DAGGLER_IP}" "grafana.${DAGGLER_DOMAIN}" +short \
    | grep -qx "${DAGGLER_IP}"; then
    echo "✓ Pi-hole local DNS is working"
else
    echo "✗ Pi-hole local DNS is not resolving correctly"
    exit 1
fi

echo
echo "Checking Caddy..."

if curl -fsSI \
    --resolve "grafana.${DAGGLER_DOMAIN}:80:${DAGGLER_IP}" \
    "http://grafana.${DAGGLER_DOMAIN}" >/dev/null; then
    echo "✓ Caddy reverse proxy is reachable"
else
    echo "✗ Caddy routing test failed"
    exit 1
fi

echo
echo "Checking system resolver..."

CURRENT_DNS="$(resolvectl dns 2>/dev/null || true)"

if grep -q "${DAGGLER_IP}" <<< "${CURRENT_DNS}"; then
    echo "✓ This machine is already using Daggler DNS"
else
    echo "! This machine is not using ${DAGGLER_IP} as DNS"
fi

echo
echo "Router/DHCP requirement:"
echo "  Configure your router's LAN DHCP DNS server as:"
echo
echo "      ${DAGGLER_IP}"
echo
echo "Do not configure a public secondary DNS if you want all clients"
echo "to consistently use Pi-hole."