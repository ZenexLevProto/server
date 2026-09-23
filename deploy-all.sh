#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ENV_FILE=${1:-"$ROOT_DIR/.env"}

cd "$ROOT_DIR"

if [[ -f "$ENV_FILE" ]]; then
	set -a
	. "$ENV_FILE"
	set +a
elif [[ -z "${RECFLARE_DOMAIN:-}" ]]; then
	echo "Environment file not found and RECFLARE_DOMAIN is not set: $ENV_FILE" >&2
	exit 1
fi

export PATH="$ROOT_DIR/packages/tools/bin:$ROOT_DIR/node_modules/.bin:$PATH"

exec pnpm exec turbo deploy --ui=stream --concurrency=30
