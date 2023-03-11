#!/usr/bin/env bash
set -e

exec caddy file-server --listen :8080 --root ./nodes