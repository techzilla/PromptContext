#!/bin/sh

SCRIPT_DIR="$(realpath "$(dirname $0)")"

#mkdir -p tmp
#TMPDIR="$PWD/tmp"

TMPDIR="$(mktemp -d)"
trap 'rm -rf $TMPDIR' EXIT HUP INT QUIT

mkdir -p "$TMPDIR/docs"

curl -s https://raw.githubusercontent.com/elastic/elasticsearch/refs/heads/main/docs/reference/query-languages/toc.yml -o "$TMPDIR/toc.yml"


cd "$TMPDIR/docs"

    yq -r '.. | .file? | select(type == "string" and startswith("esql"))' "$TMPDIR/toc.yml" | while read line; do

    curl -s "https://www.elastic.co/docs/reference/query-languages/$line" -o "$(basename "$line")"

done

find "$TMPDIR/docs" -type f -name '*.md' -print0 | xargs -0 cat  > "$SCRIPT_DIR/../elasticsearch.md"

