#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ENV_FILE=${1:-"$ROOT_DIR/.env"}

cd "$ROOT_DIR"

if [[ ! -f "$ENV_FILE" ]]; then
	echo "Environment file not found: $ENV_FILE" >&2
	exit 1
fi

set -a
. "$ENV_FILE"
set +a

export PATH="$ROOT_DIR/packages/tools/bin:$ROOT_DIR/node_modules/.bin:$PATH"

exec pnpm exec turbo dev --ui=stream --concurrency=30
