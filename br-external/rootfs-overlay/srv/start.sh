#!/bin/sh

docker load < prometheus.tar
docker load < grafana.tar

docker compose up -d
