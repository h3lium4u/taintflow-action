# TaintFlow SAST GitHub Action

**Short Description:**  
Offline Context-Sensitive Static Application Security Testing (SAST) for GitHub Actions.

---

## **Detailed Description**

TaintFlow SAST is a high-precision static application security testing (SAST) action designed to identify data flow vulnerabilities and security bugs in Java and Python projects without leaving your secure repository environment.

### **Why TaintFlow SAST?**

- **🔒 100% Offline & Private:** TaintFlow processes all files completely inside the GitHub runner environment. No code, hashes, or analysis telemetry are ever sent to external API endpoints.
- **⚡ Advanced Interprocedural Taint Tracking:** Unlike basic pattern matchers, TaintFlow tracks complex variables through function parameters, return boundaries, and class methods.
- **🛠️ Zero Configuration Setup:** Bundled language parsers (via tree-sitter) enable instant scanning without requiring pre-compilation, build scripting, or external package mapping.
- **📊 GitHub Security Center Integration:** Generates standard SARIF v2.1.0 report schemas that map directly to your repository's Security center alerts tab.

### **Supported CWE Coverage:**
- **CWE-89:** SQL Injection
- **CWE-78:** OS Command Injection
- **CWE-22:** Path Traversal
- **CWE-918:** Server-Side Request Forgery (SSRF)
- **CWE-502:** Unsafe Deserialization
- **CWE-798:** Hardcoded Credentials
- **CWE-327:** Weak Cryptographic Algorithm
