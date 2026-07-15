# TaintFlow SAST Action v1.0.0 Release Notes

Initial release of the official GitHub Action for TaintFlow SAST on the GitHub Marketplace.

### What's New
- **Production Artifact Consumption:** Action utilizes the pre-compiled, statically linked Docker images (`ghcr.io/h3lium4u/taintflow:latest`) to run scans instantly.
- **Input Parameters Integration:** Full inputs support for directory path filtering, minimum severity thresholds (`LOW`, `MEDIUM`, `HIGH`), and output formatting (`text`, `json`, `sarif`).
- **SARIF Code Security Scanning:** Outputs fully compliant SARIF reports suitable for ingestion by `github/codeql-action/upload-sarif`.
