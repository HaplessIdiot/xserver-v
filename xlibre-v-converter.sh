#!/usr/bin/env bash
#
# translate_xlibre.sh — Batch V translation of XLibre Xserver C sources
#
# Usage: ./translate_xlibre.sh /path/to/v /path/to/xlibre /path/to/output
#
set -euo pipefail

V_BIN="${1:-}"
SRC_ROOT="${2:-}"
OUT_ROOT="${3:-}"

if [[ -z "$V_BIN" || -z "$SRC_ROOT" || -z "$OUT_ROOT" ]]; then
    echo "Usage: $0 /path/to/v /path/to/xlibre /path/to/output"
    exit 1
fi

if [[ ! -x "$V_BIN" ]]; then
    echo "Error: V binary not found or not executable at $V_BIN"
    exit 1
fi

# Normalize paths
SRC_ROOT="$(realpath "$SRC_ROOT")"
OUT_ROOT="$(realpath -m "$OUT_ROOT")"

mkdir -p "$OUT_ROOT"

# Find all .c files under SRC_ROOT, relative paths only
mapfile -t c_files < <(find "$SRC_ROOT" -type f -name '*.c' -printf '%P\n')

echo "Found ${#c_files[@]} C files to translate..."

for rel_path in "${c_files[@]}"; do
    out_path="$OUT_ROOT/${rel_path%.c}.v"

    mkdir -p "$(dirname "$out_path")"

    echo "[*] Translating $rel_path -> $(realpath --relative-to="$OUT_ROOT" "$out_path")"
    if ! "$V_BIN" translate c "$SRC_ROOT/$rel_path" > "$out_path" 2> "$out_path.err"; then
        echo "    [!] Failed to translate $rel_path — see $(realpath "$out_path.err")"
    fi
done

echo "Done. Translated sources are in: $OUT_ROOT"
