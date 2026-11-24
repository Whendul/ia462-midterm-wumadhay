# Vulnerable pull-request demonstration

PR #4: <https://github.com/Whendul/ia462-midterm-wumadhay/pull/4>

The demonstration changes Flask and Werkzeug to 2.0.0 and regenerates the hashed lock on a separate branch. The main implementation retains Flask 3.1.3 and Werkzeug 3.1.9.

GitHub confirms that PR #4 is **closed and was not merged**. It also currently reports main as protected. The final API snapshot is in [pr-final-state.json](pr-final-state.json). Screenshot 22 records the blocked merge state captured before closure; screenshot 23 records the closed state. The API snapshot does not independently validate the visual content of those screenshots or every branch-rule option.

| Check | Result |
| --- | --- |
| Dependency Review | failure |
| Python Dependency Audit (pip-audit) | failure |
| Vulnerability Scan (Trivy) | failure |
| Build Docker Image | success |
| Generate SBOM (Syft, SPDX) | success |

Dependency Review annotated its failure with "Dependency review detected vulnerable packages." pip-audit failed in its dependency-audit step after successful installation; Trivy failed in its fixable High/Critical gate after producing the full report. The build and SBOM jobs succeeded.

- [Successful main run](https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45293922167)
- [Dependency Review test run](https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45296433665)
- [Security pipeline test run](https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45296433712)
- [Blocked merge screenshot](screenshots/22-vulnerable-pr-blocked.png)
- [Closed PR screenshot](screenshots/23-vulnerable-pr-closed.png)

The supplemental failed-checks screenshot predates merge enforcement. Required status checks, rather than the mere presence of red checks, provide the merge gate. Verify the final requirement for one approving review, conversation resolution, and no bypass in the repository settings and walkthrough.
