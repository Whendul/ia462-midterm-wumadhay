# Run and inspect the midterm application

The implementation and analysis are in [MIDTERM.md](MIDTERM.md). Evidence is organized under `section1` through `section6`.

From this `midterm` directory, build the patched image and start the restricted container:

```bash
docker build --pull --no-cache -t ia462-midterm:ci-ready .
bash section3/run-command.sh
```

If `ia462-midterm-ci-check` is already running from the recorded tests, inspect that existing lab container instead of starting another container with the same name:

```bash
docker exec ia462-midterm-ci-check id
curl --noproxy '*' --max-time 5 -i http://127.0.0.1:5002/
```

Expected values from the saved tests are UID/GID 999, HTTP 200 for GET and HEAD `/`, and HTTP 404 for GET `/missing`. The application uses Flask's development server for this local lab.

The current run command publishes only `127.0.0.1:5002`, applies the custom seccomp profile, drops all capabilities, enables no-new-privileges, and uses a read-only root filesystem. It assumes the container name is free when starting a new container. The original image and its port-5001 screenshots are preserved as historical evidence, as explained in [EVIDENCE-NOTES.md](EVIDENCE-NOTES.md).

Active GitHub configurations are in the repository root's `.github/` directory. The copies in `section6/` are evidence and are not executed directly by GitHub.
