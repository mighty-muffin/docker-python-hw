##  Builder Stage  ##
FROM python:3.13.7-slim@sha256:5f55cdf0c5d9dc1a415637a5ccc4a9e18663ad203673173b8cda8f8dcacef689 AS builder

ENV UV_VERSION="0.8.13"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD https://astral.sh/uv/${UV_VERSION}/install.sh /install.sh
RUN chmod -R 655 /install.sh && /install.sh && rm /install.sh

ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /app

COPY ./pyproject.toml .

RUN uv sync

##  Production Stage  ##

FROM python:3.13.7-slim-@sha256:27f90d79cc85e9b7b2560063ef44fa0e9eaae7a7c3f5a9f74563065c5477cc24 AS production

RUN useradd --create-home appuser
USER appuser

WORKDIR /app

COPY --from=builder /app/.venv .venv
COPY app/ .

ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "main.py"]
