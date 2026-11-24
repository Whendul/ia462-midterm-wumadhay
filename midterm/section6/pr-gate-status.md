# Vulnerable pull-request demonstration

Repository: <https://github.com/Whendul/ia462-midterm-wumadhay>

Successful main run: <https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45293922167>

Main commit: `6969c4490f5b742bd012375e18fc09f6d9313020`

Test PR: <https://github.com/Whendul/ia462-midterm-wumadhay/pull/4>

Test commit: `acca4e086f0bb73c93054d01a23f1c44db395e09`

The test branch changes Flask and Werkzeug to 2.0.0, regenerates the hashed lock, and updates both Section 6 copies. The main branch retains Flask 3.1.3 and Werkzeug 3.1.9.

| Check | Observed result |
| --- | --- |
| Dependency Review | Failed; GitHub annotation: "Dependency review detected vulnerable packages." |
| Python Dependency Audit (pip-audit) | Failed in "Audit direct pins and the complete hashed lock" after successful setup and audit-tool installation |
| Vulnerability Scan (Trivy) | Failed in "Block fixable High and Critical vulnerabilities" after successful setup and generation of the full report |
| Build Docker Image | Passed |
| Generate SBOM (Syft, SPDX) | Passed |

Dependency Review run: <https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45296433665>

Security pipeline run: <https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45296433712>

At the time this evidence package was prepared, PR #4 was **open and unmerged**. The supplemental `screenshots/vulnerable-pr-checks-failed.png` records check failures before merge enforcement was configured. It is not the final blocked-merge screenshot.

Completion remains pending: configure required checks, capture `22-vulnerable-pr-blocked.png` while the PR is open, close the PR without merging, and capture `23-vulnerable-pr-closed.png`. The supplied completion helper verifies the PR's closed/unmerged state before replacing this pending status with a final record.
