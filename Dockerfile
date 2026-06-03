# Sử dụng base image Python chính thức, gọn nhẹ
FROM python:3.10-slim

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Cài đặt curl để phục vụ lệnh HEALTHCHECK của Docker
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy file quản lý thư viện vào trước để tận dụng Docker cache
COPY requirements.txt .

# Cài đặt các thư viện Python cần thiết
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ mã nguồn vào container
COPY . .

# --- KHU VỰC CẤU HÌNH BẢO MẬT & MONITORING ---

# 1. Định nghĩa lệnh HEALTHCHECK tự động kiểm tra định kỳ mỗi 30 giây
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# 2. Tạo một user thường (non-root) tên là appuser và chuyển quyền sử dụng sang user này
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Mở cổng 8000
EXPOSE 8000

# Lệnh khởi chạy ứng dụng
CMD ["uvicorn", "iot_app.main:app", "--app-dir", "src", "--host", "0.0.0.0", "--port", "8000"]