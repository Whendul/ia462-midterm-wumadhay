#!/bin/bash

cd "$(dirname "$0")" || exit 1

docker run -d \
    --name ia462-midterm-ci-check \
    --read-only \
    --cap-drop ALL \
    --security-opt no-new-privileges=true \
    --security-opt seccomp=seccomp-profile.json \
    --stop-signal SIGINT \
    -p 127.0.0.1:5002:5000 \
    ia462-midterm:ci-ready
