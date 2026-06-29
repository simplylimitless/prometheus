FROM prom/prometheus:latest

# Ship the example as an in-image reference; real config is mounted at runtime.
COPY ./config/prometheus.yml.example /etc/prometheus/prometheus.yml.example
