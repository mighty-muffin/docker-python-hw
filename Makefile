.PHONY: sync
sync:
	uv sync --all-extras --all-packages --group dev

.PHONY: docker-buildx
docker-buildx:
	docker buildx build -f Dockerfile . -t docker-python-hw

.PHONY: docker-run
docker-run:
	docker run --rm -it docker-python-hw

.PHONY: format
format:
	uv run ruff format --check
	uv run ruff format
	uv run ruff check --fix

.PHONY: lint
lint:
	uv run ruff check

.PHONY: mypy
mypy:
	uv run mypy .

.PHONY: tests
tests:
	uv run pytest -v --color=yes --tb=short

.PHONY: coverage
coverage:
	uv run coverage run -m pytest
	uv run coverage xml -o coverage.xml
	uv run coverage report -m --fail-under=70
