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

# Create output parent directory if specified
if [[ -n "$OUTPUT_FILE" ]]; then
  mkdir -p "$(dirname "$OUTPUT_FILE")"
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

# Execute pre-built Docker image with mounted workspace volume and mapped user ID
docker run --rm \
  --user "$(id -u):$(id -g)" \
  -v "$(pwd):/workspace" \
  ghcr.io/h3lium4u/taintflow:latest \
  "${ARGS[@]}"

# Post-run check for output file if expected
if [[ -n "$OUTPUT_FILE" ]]; then
  if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "::error::ERROR: TaintFlow completed but $FORMAT file was not generated."
    echo "::error::Expected: $OUTPUT_FILE"
    echo "::error::Check: output path, format flag, and CLI arguments."
    exit 1
  else
    echo "✅ Successfully generated $FORMAT report: $OUTPUT_FILE"
  fi
fi
