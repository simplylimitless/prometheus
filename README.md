# prometheus

Prometheus configuration for Docker-based monitoring setups. Docker-based, scraping Prometheus itself, multiple node exporters (via `node_exporter` containers), and Home Assistant's Prometheus API.

**Supported architectures:** `linux/amd64`, `linux/arm64`, `linux/arm/v7` — the published image is a multi-arch manifest, so `docker pull`/`docker run` automatically select the right variant for your host (x86_64 servers, 64-bit Raspberry Pi 4/5, and 32-bit Raspberry Pi 2/3).

## Quick start

### Deploy from GitHub Container Registry

```bash
docker login ghcr.io -u YOUR_GITHUB_USERNAME   # password: a GitHub PAT with `packages` scope (create one at https://github.com/settings/tokens, not the fine-grained type)
docker pull ghcr.io/simplylimitless/prometheus:latest
docker run -p 9090:9090 --name prometheus ghcr.io/simplylimitless/prometheus:latest
```

### Or build locally

```bash
docker build -t prometheus .
docker run -p 9090:9090 --name prometheus prometheus
```

### With Docker Compose (recommended)

```bash
# 1. Create your live config from the example
cp config/prometheus.yml.example config/prometheus.yml
# 2. Edit config/prometheus.yml — add real tokens, adjust targets

docker compose up --build -d
```

Browse to `http://localhost:9090`.

### Compose volumes

| Mount | Purpose |
|-------|---------|
| `./config` → `/etc/prometheus` | Prometheus config files (`prometheus.yml`, rules, etc.) |

No data volume is mounted by default — all metrics are stored inside the container and will be lost on recreate. For persistence, add a named volume to your compose file:

```yaml
volumes:
  prometheus_data:

services:
  prometheus:
    # ...
    volumes:
      - ./config:/etc/prometheus
      - prometheus_data:/prometheus
```

Or bind-mount an existing directory instead (`- /host/path:/prometheus`).

> **Note:** After setting up the `GHCR_PAT` secret, re-run the workflow from the Actions tab or push a test commit if you don't see the image published yet.

### CI/CD

Pushing to `main` triggers an automatic multi-arch build (`linux/amd64`, `linux/arm64`, `linux/arm/v7`, via Docker Buildx + QEMU — see [`.github/workflows/docker.yml`](.github/workflows/docker.yml)). Each push is tagged with both `latest` and a numeric build ID for rollback:

```bash
docker pull ghcr.io/simplylimitless/prometheus:3
```

**GHCR write permission:** The workflow uses a PAT stored in the repository secret `GHCR_PAT` to push to GitHub Container Registry. Create one at https://github.com/settings/tokens (classic tokens, not fine-grained — that scope isn't available there) with the **`packages`** scope ticked, then add it as a repo secret named `GHCR_PAT`. The automatic `GITHUB_TOKEN` doesn't grant GHCR package write permissions, so this PAT is required.

## Configuration

`.gitignore` excludes `config/prometheus.yml` (contains secrets, injected at deploy time). A clean template ships as [`config/prometheus.yml.example`](config/prometheus.yml.example). Copy to `prometheus.yml` and fill in your targets / tokens.


