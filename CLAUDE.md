# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Structure

- `Dockerfile` — Builds from `prom/prometheus:latest`, ships `config/prometheus.yml.example` as an in-image reference.
- `.gitignore` — Ignores `config/prometheus.yml` (contains secrets, injected at deploy time).
- `config/prometheus.yml.example` — Sanitized template showing the full scrape configuration. Copy to `prometheus.yml` and fill in your targets / tokens.

## How to run

```bash
# 1. Create your live config from the example
cp config/prometheus.yml.example config/prometheus.yml
# 2. Edit config/prometheus.yml — add real tokens, adjust targets

docker build -t homelab-prometheus .
docker run -p 9090:9090 --name prometheus -v $(pwd)/config:/etc/prometheus homelab-prometheus
```

## Configuration

`config/prometheus.yml.example` defines a minimal config with self-monitoring and one example node exporter job. Copy to `prometheus.yml` and add your targets.
