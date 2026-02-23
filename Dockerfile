FROM python:3.12-slim

# Install system packages in a single layer to reduce image size
RUN apt-get update && apt-get install -y \
  gcc \
  libpq-dev \
  libjpeg-dev \
  zlib1g-dev \
  netcat-openbsd \
  && rm -rf /var/lib/apt/lists/*

# Install uv (high-performance Python package installer)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Dependency installation using uv
COPY pyproject.toml uv.lock* ./
RUN uv pip install --system --no-cache . gunicorn

# Copy the rest of the application code
COPY . .

# Set up the entrypoint script for migrations and setup
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000

# Default command for production using Gunicorn
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
