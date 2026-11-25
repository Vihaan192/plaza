FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml uv.lock ./
ENV UV_NO_DEV=1
RUN uv sync --locked

COPY . .

RUN uv run --no-sync python manage.py collectstatic --noinput

CMD ["uv", "run", "--no-sync", "gunicorn", "dvm_task.wsgi:application", "--bind", "0.0.0.0:8000"]