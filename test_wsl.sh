#!/bin/bash
# Script Pengujian AWS Lambda dari Terminal WSL 2 / Kali Linux / Ubuntu

echo "========================================================"
echo "    PENGUJIAN AWS LAMBDA DARI TERMINAL LINUX / WSL 2    "
echo "========================================================"

# Ganti dengan Function URL AWS Lambda Anda dari AWS Console (jika masih aktif)
# Contoh: AWS_LAMBDA_URL="https://xxxxxxxx.lambda-url.ap-southeast-3.on.aws/"
AWS_LAMBDA_URL="$1"
LOCAL_URL="http://localhost:9000"

if [ -n "$AWS_LAMBDA_URL" ]; then
    echo "[1] Menguji AWS Lambda Cloud Function URL: $AWS_LAMBDA_URL"
    curl -i "$AWS_LAMBDA_URL"
    echo ""
else
    echo "[INFO] Anda dapat menguji AWS Lambda asli dengan: ./test_wsl.sh <URL_LAMBDA_ANDA>"
fi

echo ""
echo "[2] Menguji Server Lambda Lokal (port 9000):"
if curl -s --head --request GET "$LOCAL_URL" | grep "200 OK" > /dev/null; then
    echo "✓ Server lokal aktif dan merespons HTTP 200 OK!"
    echo "Tampilan awal konten:"
    curl -s "$LOCAL_URL" | grep -i "Hello from AWS Lambda" -A 1
else
    echo "⚠ Server lokal belum aktif. Jalankan 'npm start' atau 'node local_server.mjs' terlebih dahulu."
fi

echo "========================================================"
