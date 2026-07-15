#!/usr/bin/env bash
set -eo pipefail

SCAN_PATH="$1"
FORMAT="$2"
SEVERITY="$3"
OUTPUT_FILE="$4"

# Validate format input
if [[ "$FORMAT" != "text" && "$FORMAT" != "json" && "$FORMAT" != "sarif" ]]; then
  echo "::error::Invalid format '$FORMAT'. Allowed values: text, json, sarif."
  exit 1
fi

# Validate severity input
if [[ "$SEVERITY" != "LOW" && "$SEVERITY" != "MEDIUM" && "$SEVERITY" != "HIGH" ]]; then
  echo "::error::Invalid severity '$SEVERITY'. Allowed values: LOW, MEDIUM, HIGH."
  exit 1
fi

# Build argument array
ARGS=("scan" "/workspace/$SCAN_PATH" "--format" "$FORMAT" "--severity" "$SEVERITY")

if [[ -n "$OUTPUT_FILE" ]]; then
  ARGS+=("--output" "/workspace/$OUTPUT_FILE")
fi

echo "🚀 Starting TaintFlow SAST Analysis..."
echo "📂 Scanning path: $SCAN_PATH"
echo "📊 Severity threshold: $SEVERITY"
echo "📝 Format: $FORMAT"

# Execute pre-built Docker image with mounted workspace volume
docker run --rm \
  -v "$(pwd):/workspace" \
  ghcr.io/h3lium4u/taintflow:latest \
  "${ARGS[@]}"
