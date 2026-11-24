# Evidence handling and scope

The original Linux files remain in the local `ia462-midterm-evidence/section1` directory, and the original Windows files remain in `ia462-midterm-evidence/section2`. The review archive also retains the originals. The public copies in this repository are derived from those collected files; missing outputs were not invented.

## Text redactions

Local account names, the host name, domain/account SIDs, email addresses, MAC addresses, private IP addresses, and machine identifiers were replaced with visible redaction markers where applicable. Lab accounts such as `ia462student` and `ia462midterm`, standard system identities, repository identifiers, loopback addresses, event IDs, timestamps, numeric privileges, and package versions were retained.

Private home-directory filenames in the world-writable inventories were replaced with consistent numbered path markers. Each original path still occupies one line, and repeated original paths retain the same marker. The public inventory therefore preserves the 189,495 total entries and the 188,609 `/mnt/c` entries without publishing personal filenames. The 63 SUID paths and 397 full-scan error lines remain available. Consult the original local files if exact redacted paths are needed for administration.

Terminal escape sequences, OSC metadata, NUL characters, and backspace control effects were normalized for readable text. Windows text is UTF-8, and the JSON exports remain valid JSON with their original event counts and IDs. The `net user ... * /add` command prompted interactively for a password; the asterisk is an interactive prompt argument and is retained.

Screenshots are unchanged as requested and can still display local account or computer names. Redaction of text files does not anonymize those images. No claims, scores, output statuses, or screenshot results were changed.

## Organization changes

- Linux and Windows text/configuration evidence was copied into Sections 1 and 2.
- `19-docker-bench.png` was moved from the Section 4 screenshot folder to Section 5.
- The successful main screenshot was named `section6/screenshots/21-actions-green-main.png`.
- The failed-checks screenshot is supplementary. Screenshots 22 and 23 must be captured from the actual protected and closed PR states.

## Image and report history

The Section 4 reports, SPDX SBOM, original container evidence, and Docker Bench run describe the original hardened image/host state. The Section 6 package list, local Trivy gate, and runtime test describe the patched `ia462-midterm:ci-ready` image. The successful GitHub workflow built a separate image from the updated Dockerfile and independently ran its CI jobs. Those observations should not be presented as a single image with one immutable ID.

The final `section3/run-command.sh` reproduces the already-tested patched container named `ia462-midterm-ci-check`, using host loopback port 5002. The original screenshots and records on port 5001 remain historical evidence. No host-wide daemon settings were applied by preparing these files.
