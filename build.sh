#!/usr/bin/env bash
set -euo pipefail
rm -rf public && mkdir -p public/img
cp src/index.html public/
cp src/robots.txt public/
cp src/sitemap.xml public/
for b in assets/bundle*.txt; do
  while read -r name data || [ -n "${name:-}" ]; do
    [ -z "$name" ] && continue
    case "$name" in favicon.png|apple-touch-icon.png) out="public/$name";; *) out="public/img/$name";; esac
    printf '%s' "$data" | base64 -d > "$out"
  done < "$b"
done
ls -la public public/img
