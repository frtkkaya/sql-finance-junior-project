#!/usr/bin/env bash
set -euo pipefail
DB=lab.db
if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "sqlite3 is required. Install it and re-run." >&2
  exit 1
fi
rm -f "$DB"
sqlite3 "$DB" < sql/schema.sql
sqlite3 "$DB" ".read sql/seed.sql"
echo "Database created: $DB"
