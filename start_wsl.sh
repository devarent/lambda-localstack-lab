#!/bin/bash

# Script untuk menjalankan AWS Lambda Simulator di WSL 2 Ubuntu menggunakan Docker
# Cara penggunaan: bash start_wsl.sh

echo "=========================================="
echo "AWS Lambda Simulator - WSL 2 Docker Mode"
echo "=========================================="
echo ""

# Masuk ke folder proyek
cd "/mnt/c/laragon/www/aws-lambda-practicum" || exit 1

# Cek apakah container sudah ada
if docker ps -a --format '{{.Names}}' | grep -q "lambda-container"; then
    echo "Container sudah ada, menghentikan dan menghapus..."
    docker stop lambda-container 2>/dev/null
    docker rm lambda-container 2>/dev/null
fi

# Build image (jika belum ada)
echo "Building Docker image..."
docker build -t lambda-pert5 . || exit 1

# Jalankan container
echo "Menjalankan container..."
docker run -d -p 9000:9000 --name lambda-container lambda-pert5

echo ""
echo "=========================================="
echo "Server berjalan di WSL 2 Docker!"
echo "=========================================="
echo "Akses dari browser Windows: http://localhost:9000"
echo "Akses dari WSL 2: curl http://localhost:9000"
echo ""
echo "Cek logs: docker logs lambda-container"
echo "Stop container: docker stop lambda-container"
echo "Hapus container: docker rm lambda-container"
echo "=========================================="
