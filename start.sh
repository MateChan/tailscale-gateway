#!/bin/sh

set -e

: "${TS_AUTHKEY?TS_AUTHKEY is not set or empty}"
: "${TS_ROUTES?TS_ROUTES is not set or empty}"
: "${TS_HOSTNAME?TS_HOSTNAME is not set or empty}"

tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
TAILSCALED_PID=$!

sleep 3

tailscale set --advertise-exit-node
tailscale up \
  --authkey="${TS_AUTHKEY}" \
  --hostname="${TS_HOSTNAME}" \
  --advertise-routes="${TS_ROUTES}"

echo "Tailscale started successfully. Container will keep running."

wait ${TAILSCALED_PID}
