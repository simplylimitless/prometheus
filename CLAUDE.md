# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Structure

- `Dockerfile` — Builds from `prom/prometheus:latest`. No bundled config; real config is mounted at runtime.
- `.gitignore` — Ignores `config/prometheus.yml` (contains secrets, injected at deploy time).
- `config/prometheus.yml.example` — Sanitized template showing the full scrape configuration. Copy to `prometheus.yml` and fill in your targets / tokens.
- `docker-compose.yml` — Local dev setup; mounts `./config` into `/etc/prometheus`.
