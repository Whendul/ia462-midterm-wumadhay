# Custom seccomp profile

The profile was derived from `app.strace`, which captured application startup, GET `/`, HEAD `/`, GET `/missing`, and shutdown. The trace contains 53 distinct syscall names. The final policy defaults to `SCMP_ACT_ERRNO` with errno 1 and targets x86-64.

The policy has 61 distinct syscall names with allow actions: 50 unrestricted names observed in the trace, five read-only identity calls for `id`/`whoami` verification, `clone` with the observed thread flags, `socket` restricted to AF_UNIX or AF_INET, and four runtime compatibility calls. `clone3` is a separate errno-38 rule, not an allowed call. It returns ENOSYS so glibc can use the observed `clone` fallback.

The four runtime compatibility allowances are `close_range`, `fstatfs`, `openat2`, and `statx`. They were added while resolving container startup failures and are explicitly identified as outside the application trace. Their individual necessity has not been established through isolated removal tests. The profile therefore demonstrates a workload-informed allowlist with documented exceptions, rather than a claim that every permitted call has been proven essential.

Kernel audit messages include denied `statfs` calls from `id` and a denied `clone3` call from Python. `id` still returned UID/GID 999, and the application returned the expected responses. The `clone3` denial is consistent with the deliberate fallback behavior. No additional syscall was allowed merely to eliminate these messages.

The original image's runtime evidence shows zero effective/bounding capabilities, `NoNewPrivs: 1`, and `Seccomp: 2`. The patched image was tested with the same profile and restrictions; its saved results are in `../section6/ci-runtime-test.txt` and its configuration is in `../section6/ci-runtime-inspect.json`.

`Dockerfile.trace` and the trace are historical diagnostic artifacts. The final runtime uses the revised multi-stage Dockerfile and the patched `ia462-midterm:ci-ready` image. `run-command.sh` reproduces that tested configuration on host loopback port 5002. It expects that the image is already built and that the named container does not already exist.
