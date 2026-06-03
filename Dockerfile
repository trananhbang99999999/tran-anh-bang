FROM python:3.11-slim AS builder
WORKDIR /app
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim AS runner
WORKDIR /app
RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -m -s /bin/bash appuser
COPY --from=builder /opt/venv /opt/venv
COPY --chown=appuser:appgroup src/ ./src

ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH="/app/src" 

USER appuser
EXPOSE 8000

# Thêm biến PYTHONPATH="/app/src" ở trên giúp Uvicorn luôn luôn tìm thấy thư mục iot_app
CMD ["uvicorn", "iot_app.main:app", "--host", "0.0.0.0", "--port", "8000"]