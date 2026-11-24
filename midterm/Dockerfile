FROM python:3.15-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928 AS base
# Apply available Debian fixes before deriving either image stage.
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

FROM base AS builder

WORKDIR /build
COPY requirements.lock .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir --require-hashes \
       --only-binary=:all: -r requirements.lock \
    && /opt/venv/bin/pip uninstall --yes pip setuptools

FROM base AS runtime

ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN python -m pip uninstall --yes pip setuptools wheel \
    && groupadd --system appgroup \
    && useradd --system --gid appgroup --home-dir /app \
       --shell /usr/sbin/nologin appuser

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv
COPY --chmod=644 app/app.py ./app/app.py
RUN chmod 755 /app /app/app && chmod 644 /app/app/app.py

USER appuser
EXPOSE 5000

CMD ["python", "app/app.py"]
