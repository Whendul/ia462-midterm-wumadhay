# Section 6 CI configuration

The active workflows and Dependabot configuration live in the repository's
root `.github/` directory. Copies in this directory are submission evidence.
After editing an active file, update its evidence copy too.

The pipeline builds once and passes that same image to Trivy and Syft through
an Actions artifact. Python dependency auditing runs independently of the
image build. Actions use full commit SHAs. Trivy 0.76.2, Syft 1.57.2, and
pip-audit 2.10.1 are specified explicitly.

Trivy saves an unfiltered vulnerability report and blocks fixable High or
Critical findings, matching the Lab 4 gate policy. Findings without an available
fix remain in the full report. A green gate does not mean the image has no
vulnerabilities. pip-audit checks both direct pins and the complete hashed lock
and fails if either audit fails. Dependency Review blocks newly introduced
High or Critical advisories on pull requests. No advisory is allowlisted.

The original Section 4 scan identified a fixable High zlib vulnerability and
available glibc updates. The revised Dockerfile introduces a common base stage
that applies available Debian package updates before either builder or runtime
is derived. The original Python base digest and application dependency lock
remain pinned. Debian updates come from the configured repositories at build
time, so the complete image is not bit-for-bit reproducible across dates.
`--no-cache` ensures CI refreshes that package-update layer.

Section 4 reports and the Docker Bench report remain historical observations of the original image and host. Section 6 contains the patched image's local build, package versions, Trivy gate, and runtime tests. The saved runtime test confirms UID/GID 999 and GET/HEAD/missing-page results of 200/200/404. The final run script targets the already-tested `ia462-midterm:ci-ready` image and `ia462-midterm-ci-check` container on loopback port 5002. Earlier Section 3 evidence describes the original image on port 5001.

The Security CI/CD Pipeline passed on main commit `6969c4490f5b742bd012375e18fc09f6d9313020`: <https://github.com/Whendul/ia462-midterm-wumadhay/actions/runs/45293922167>.

PR #4 intentionally changes Flask and Werkzeug to 2.0.0 and regenerates the lock. Dependency Review, pip-audit, and Trivy fail while the build and SBOM jobs pass. Dependency Review explicitly reports vulnerable packages; the other failures occur in the audit/gate steps after setup succeeds. The PR remains separate from the secure main requirements. Its current closure and merge-enforcement evidence are documented in [pr-gate-status.md](pr-gate-status.md).

## Verified action pins

These release references were resolved from the official repositories with
`git ls-remote` on November 23, 2026. Annotated tags were dereferenced to commits.

| Action | Release | Commit |
| --- | --- | --- |
| actions/checkout | v7.0.0 | 9c091bb21b7c1c1d1991bb908d89e4e9dddfe3e0 |
| actions/setup-python | v7.1.0 | 6d4fd22b20465ccc0f7354476588e8df7c9ca0e0 |
| actions/upload-artifact | v7.0.2 | cf430e030ddbb5b0abf93d22962f4752f3646cd9 |
| actions/download-artifact | v8.0.2 | 9000827ccba6bdab643e8b6fd33ac0654aef8333 |
| aquasecurity/trivy-action | v0.36.0 | ed142fd0673e97e23eac54620cfb913e5ce36c25 |
| anchore/sbom-action/download-syft | v0.24.3 | 66cbf4bc1f1c0d2edc94016e65bc221b6bb0ad6c |
| actions/dependency-review-action | v5.0.0 | a1d282b36b6f3519aa1f3fc636f609c47dddb294 |

Sources:

- https://github.com/actions/checkout/releases/tag/v7.0.0
- https://github.com/actions/setup-python/releases/tag/v7.1.0
- https://github.com/actions/upload-artifact/releases/tag/v7.0.2
- https://github.com/actions/download-artifact/releases/tag/v8.0.2
- https://github.com/aquasecurity/trivy-action/releases/tag/v0.36.0
- https://github.com/anchore/sbom-action/releases/tag/v0.24.3
- https://github.com/actions/dependency-review-action/releases/tag/v5.0.0
- https://pypi.org/project/pip-audit/2.10.1/
