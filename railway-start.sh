#!/bin/sh
# Railway wrapper for Mission Control. Hands over to the upstream entrypoint.
set -e

# Mission Control rejects every Host header that isn't allow-listed (production
# default). Add the Railway domains and Railway's health-check host to whatever
# the deployer set in MC_ALLOWED_HOSTS (for example a custom domain).
hosts="${MC_ALLOWED_HOSTS:-}"
for h in "${RAILWAY_PUBLIC_DOMAIN:-}" "${RAILWAY_PRIVATE_DOMAIN:-}" healthcheck.railway.app; do
  [ -n "$h" ] && hosts="${hosts:+$hosts,}$h"
done
export MC_ALLOWED_HOSTS="$hosts"

# No OpenClaw gateway is bundled: run in standalone mode unless told otherwise.
export NEXT_PUBLIC_GATEWAY_OPTIONAL="${NEXT_PUBLIC_GATEWAY_OPTIONAL:-true}"

DATA_DIR="${MISSION_CONTROL_DATA_DIR:-/app/.data}"
if [ "$(id -u)" = "0" ]; then
  mkdir -p "$DATA_DIR"
  chown -R nextjs "$DATA_DIR"
  chmod 700 "$DATA_DIR"
  export HOME=/nonexistent USER=nextjs
  exec setpriv --reuid=nextjs --regid=nogroup --init-groups /app/docker-entrypoint.sh
fi
exec /app/docker-entrypoint.sh
