# Changelog

Breaking changes are listed first in each entry.

## 2.3.0 (2026-11-18)

- First release of the Railway template: Mission Control 2.3.0 (`ghcr.io/builderz-labs/mission-control:2.3.0@sha256:695063d5f12bba3cfe1582f56f88b08a2a2bef548d57662d41d51f87e79679a5`).
- SQLite data, generated keys and backups on a volume at `/app/.data`; admin seeded from a generated `AUTH_PASS`; health check `/api/health`.
