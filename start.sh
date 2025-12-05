#!/bin/sh

set -e

: "${TS_AUTHKEY?TS_AUTHKEY is not set or empty}"
: "${TS_ROUTES?TS_ROUTES is not set or empty}"
: "${TS_HOSTNAME?TS_HOSTNAME is not set or empty}"

tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
TAILSCALED_PID=$!

until tailscale status >/dev/null 2>&1; do
  echo "Waiting for tailscaled to start..."
  sleep 1
done

tailscale up \
  --authkey="${TS_AUTHKEY}" \
  --hostname="${TS_HOSTNAME}" \
  --advertise-routes="${TS_ROUTES}" \
  --accept-routes \
  $( [ "${TS_EXIT_NODE}" = "true" ] && echo "--advertise-exit-node" )

echo "Tailscale started successfully. Container will keep running."

wait ${TAILSCALED_PID}
