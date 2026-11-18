# Mission Control (https://github.com/builderz-labs/mission-control), official image,
# pinned by version and digest. Bump both together; see CHANGELOG.md.
FROM ghcr.io/builderz-labs/mission-control:2.3.0@sha256:695063d5f12bba3cfe1582f56f88b08a2a2bef548d57662d41d51f87e79679a5

# The start script runs as root only long enough to hand the (root-owned) Railway
# volume at /app/.data to the app user, then drops to uid 1001 (nextjs).
USER root
COPY --chmod=755 railway-start.sh /app/railway-start.sh
RUN mkdir -p /app/.next/cache && chown -R nextjs /app/.next/cache

ENV PORT=3000 \
    HOSTNAME=0.0.0.0
EXPOSE 3000
ENTRYPOINT ["/app/railway-start.sh"]
