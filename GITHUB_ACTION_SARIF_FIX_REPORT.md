# GitHub Action SARIF Generation Fix Report

This report documents the root cause, corrections, and validation of the TaintFlow SAST GitHub Action SARIF generation failure.

---

## 1. Root Cause Analysis

We identified two critical issues causing the SARIF generation failure (exit code `101` / missing file):

1.  **CLI Argument Parser Mismatch:**
    *   **Incorrect Behavior:** The old Docker Action passed arguments as `scan --path . --format sarif --output taintflow-results.sarif`.
    *   **CLI Implementation:** The CLI parser expects `scan <path>` positional argument without the `--path` flag. Thus, the parser evaluated `--path` as the directory path to scan, finding zero files and generating empty results.
2.  **Container Volume Permission Denied (Fatal Blocker):**
    *   **Behavior:** The Docker Action ran under the low-privilege `USER taintflow` container account.
    *   **Blocker:** On GitHub Action hosts, the mounted workspace volume (`/github/workspace`) is owned by the `runner` user. The `taintflow` container user lacked permission to write output files inside the mounted workspace. This caused the CLI's `fs::write` function to fail with a `PermissionDenied` error, triggering a panic (exit code `101`) before the file could be written.

---

## 2. Implemented Corrections

We transitioned the Action to a **Composite Action** and hardened the integration layer:

*   **User Mapping:** Added `--user "$(id -u):$(id -g)"` to the `docker run` command inside `entrypoint.sh`. This runs the container with the host runner's UID/GID, granting full write access to the mounted `/workspace` folder.
*   **Directory Creation:** Pre-creates the parent directory of the output path before container invocation.
*   **CLI Mapping:** Formats the parameters to match the CLI positional syntax (`scan /workspace/$SCAN_PATH --format $FORMAT --severity $SEVERITY --output /workspace/$OUTPUT_FILE`).
*   **Post-Run Validation:** Added verification checks that fail the action with clear diagnostic messages if the output file is not created successfully.

---

## 3. Before vs. After Behavior

*   **Before:** CLI parses `--path` as directory, finds nothing, and crashes with `exit code 101` when attempting to write reports to the root-owned workspace directory.
*   **After:** Scanner executes cleanly under host UID, scans the targeted codebase path, and writes the SARIF report to the workspace.
