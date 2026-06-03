# Hướng dẫn chạy dịch vụ IoT Ingestion Local (Lab 04)

Tài liệu này hướng dẫn cài đặt, đóng gói và chạy kiểm thử dịch vụ IoT Ingestion tự động bằng Docker và Newman trong 3 bước nhanh chóng.

## 1. Chuẩn bị môi trường
Đảm bảo máy cá nhân đã cài đặt sẵn:
* Docker Desktop / Docker Engine
* Node.js v20.x LTS & npm

## 2. Các bước khởi chạy hệ thống

### Bước 1: Build Docker Image
Thực hiện xây dựng Docker Image bảo mật (chạy bằng user non-root và tích hợp HEALTHCHECK):
```bash
docker build -t fit4110/iot-ingestion:lab04 .