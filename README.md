# homelab-prometheus

Prometheus configuration for a homelab monitoring setup. Docker-based, scraping Prometheus itself, multiple node exporters (via `node_exporter` containers), and Home Assistant's Prometheus API.

## Quick start

### Deploy from GitHub Container Registry

```bash
docker login ghcr.io -u YOUR_GITHUB_USERNAME
docker pull ghcr.io/simplylimitless/homelab-prometheus:latest
docker run -p 9090:9090 --name prometheus ghcr.io/simplylimitless/homelab-prometheus:latest
```

### Or build locally

```bash
docker build -t homelab-prometheus .
docker run -p 9090:9090 --name prometheus homelab-prometheus
```

Browse to `http://localhost:9090`.

### CI/CD

Pushing to `main` triggers an automatic build (see [`.github/workflows/docker.yml`](.github/workflows/docker.yml)). Each push is tagged with both `latest` and a numeric build ID for rollback:

```bash
docker pull ghcr.io/simplylimitless/homelab-prometheus:3
```

See [CLAUDE.md](CLAUDE.md) for the full list of scrape targets and config details.
# homelab-prometheus
