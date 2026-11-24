# Docker Bench findings

Docker Bench for Security 1.6.0 ran on the WSL Docker host on November 23, 2026.
The corrected run completed 117 checks, reported a score of 17, and returned
exit status 0. The score is the tool's score, not a compliance percentage.
The audit covered the local host, seven images, and two containers, including
one running container. It was not limited to the midterm image.

The initial run encountered shell and image-list parsing errors. The rerun used
Bash and changed the image-ID enumeration to `docker image ls --quiet`. The
source commit, compatibility patch, initial report, corrected report, and exit
status are retained separately. No checks were removed or forced to pass.

The running hardened container passed checks for restricted capabilities,
non-privileged operation, a read-only root filesystem, binding to a specific
host interface, seccomp enabled, no-new-privileges, and no Docker socket mount.
Separate `id` evidence confirms that the application runs as UID/GID 999.

Remaining warnings include missing host Docker audit rules, daemon-wide
hardening settings, no container AppArmor profile, no health check, and no
memory, CPU, or PID limits. Port 5001 is the intentional local test endpoint;
the run command binds it to 127.0.0.1. Image warnings also cover unrelated lab
and base images. These findings are documented, not claimed as remediated.

The daemon configuration is a sample and was not applied globally. Container
no-new-privileges passes even though the daemon-wide default produces a warning.
Swarm is disabled, so Swarm-related PASS results do not establish that a Swarm
deployment was hardened. A tool PASS is not a substitute for inspecting the
actual configuration, including the container's restart policy.
