# TaintFlow SAST GitHub Action

This action runs the **TaintFlow SAST** scanner inside your CI/CD pipeline to detect context-sensitive data flows and security vulnerabilities in Java and Python codebases.

---

## 🌟 Features

- **Offline SAST:** Does not send source code or metadata to any external servers.
- **Context-Sensitive Taint Analysis:** Tracks complex variables flows across scopes, resolving sources to unsafe sinks.
- **Multi-Language Support:** Fully supports Java and Python.
- **Standardized Outputs:** Supports console logging, JSON reports, and SARIF v2.1.0 output for GitHub Security alerts.
- **Docker Powered:** Runs inside a lightweight, sandboxed runner environment utilizing pre-built static Docker binaries.

---

## 🚀 Usage

Create or update a workflow file (e.g. `.github/workflows/security-scan.yml`):

```yaml
name: Security Scan

on:
  pull_request:
  push:

jobs:
  taintflow:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Run TaintFlow SAST Scan
        uses: h3lium4u/taintflow-action@v1
        with:
          path: '.'
          format: 'sarif'
          severity: 'LOW'
          output: 'taintflow.sarif'

      - name: Upload SARIF Report
        if: always()
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: taintflow.sarif
```

---

## 📋 Inputs

| Input | Description | Required | Default |
| :--- | :--- | :--- | :--- |
| **`path`** | Relative path to scan inside the workspace. | No | `.` |
| **`format`** | Output report format (`text`, `json`, `sarif`). | No | `text` |
| **`severity`**| Minimum severity threshold (`LOW`, `MEDIUM`, `HIGH`). | No | `LOW` |
| **`output`** | Output report file path. | No | `""` |

---

## 📊 Outputs

| Output | Description |
| :--- | :--- |
| **`result`** | The console output of the scanner. |

---

## 🔒 GitHub Code Scanning Integration

TaintFlow SAST supports native integration with GitHub Code Scanning. By outputting analysis results in the SARIF v2.1.0 format, security warnings and interprocedural taint flow graphs can be reviewed directly in your repository's **Security** tab.

### Setup Workflow Example

```yaml
name: TaintFlow Security Scan

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  taintflow:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
      contents: read
    steps:
      - uses: actions/checkout@v4
      - name: Run TaintFlow
        uses: h3lium4u/taintflow-action@v1
        with:
          path: .
          format: sarif
          output: taintflow-results.sarif
      - name: Upload SARIF
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: taintflow-results.sarif
```

### Viewing Results

Vulnerabilities will be displayed in the Security center:

![GitHub Security Alerts Interface Placeholder](docs/images/security_tab_preview.png)

