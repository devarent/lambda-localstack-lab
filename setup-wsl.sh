#!/bin/bash

# Menu utama setup untuk WSL 2 Ubuntu
# Pilih metode yang ingin digunakan:
# 1. LocalEmu (Full AWS Emulator - Rekomendasi)
# 2. Docker Simple (Hanya Lambda simulator)
# 3. Manual Setup

echo "=========================================="
echo "Setup AWS Lambda - WSL 2 Ubuntu"
echo "=========================================="
echo ""
echo "Pilih metode setup:"
echo "1) LocalEmu (Full AWS Emulator - 133+ layanan)"
echo "2) Docker Simple (Hanya Lambda simulator)"
echo "3) Buka panduan lengkap"
echo ""
read -p "Pilihan (1/2/3): " choice

case $choice in
    1)
        echo ""
        echo "Setup LocalEmu..."
        cd "/mnt/c/laragon/www/aws-lambda-practicum"
        chmod +x localemu-setup.sh
        bash localemu-setup.sh
        echo ""
        echo "Setelah LocalEmu berjalan, deploy Lambda:"
        echo "bash deploy-lambda-localemu.sh"
        ;;
    2)
        echo ""
        echo "Setup Docker Simple..."
        cd "/mnt/c/laragon/www/aws-lambda-practicum"
        docker build -t lambda-pert5 .
        docker stop lambda-container 2>/dev/null
        docker rm lambda-container 2>/dev/null
        docker run -d -p 9000:9000 --name lambda-container lambda-pert5
        echo ""
        echo "Server berjalan di http://localhost:9000"
        echo "Test: curl -i http://localhost:9000"
        ;;
    3)
        echo ""
        echo "Buka panduan: GUIDE_LOCALEMU.md"
        echo "Atau README.md untuk panduan lengkap"
        ;;
    *)
        echo "Pilihan tidak valid"
        exit 1
        ;;
esac
