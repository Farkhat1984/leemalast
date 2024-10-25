FROM python:3.10.11-slim AS builder

WORKDIR /leema

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

FROM python:3.10.11-slim

WORKDIR /leema

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy application files
COPY --from=builder /leema /leema
# Copy installed packages
COPY --from=builder /usr/local/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages/

# Set ownership
RUN chown -R appuser:appuser /leema

USER appuser

EXPOSE 5001

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5001", "main:app"]