#!/bin/bash

# Script untuk deploy Lambda function ke LocalEmu
# LocalEmu mensimulasikan AWS Lambda tanpa perlu akun AWS

echo "=========================================="
echo "Deploy Lambda Function ke LocalEmu"
echo "=========================================="
echo ""

# Set environment variables untuk LocalEmu
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1

# Masuk ke folder proyek
cd "/mnt/c/laragon/www/aws-lambda-practicum" || exit 1

# Cek apakah LocalEmu berjalan
if ! curl -s http://localhost:4566/_localemu/health > /dev/null; then
    echo "❌ LocalEmu tidak berjalan. Jalankan dulu: bash localemu-setup.sh"
    exit 1
fi

echo "✓ LocalEmu berjalan di http://localhost:4566"
echo ""

# Buat IAM role untuk Lambda
echo "Membuat IAM role..."
ROLE_ARN=$(aws iam create-role \
    --role-name lambda-execution-role \
    --assume-role-policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}' \
    --query Role.Arn \
    --output text)

echo "✓ Role dibuat: $ROLE_ARN"
echo ""

# Buat ZIP deployment package
echo "Membuat deployment package..."
zip -r function.zip index.mjs index.html

# Buat Lambda function
echo "Membuat Lambda function..."
aws lambda create-function \
    --function-name lambda-wsl-tutorial \
    --runtime nodejs22.x \
    --handler index.handler \
    --role "$ROLE_ARN" \
    --zip-file fileb://function.zip \
    --timeout 30

echo ""
echo "✓ Lambda function dibuat!"
echo ""

# Buat Function URL
echo "Membuat Function URL..."
aws lambda create-function-url-config \
    --function-name lambda-wsl-tutorial \
    --auth-type NONE

echo "✓ Function URL dibuat!"
echo ""

# Dapatkan Function URL
FUNCTION_URL=$(aws lambda get-function-url-config \
    --function-name lambda-wsl-tutorial \
    --query FunctionUrl \
    --output text)

echo ""
echo "=========================================="
echo "Deploy Selesai!"
echo "=========================================="
echo "Function URL: $FUNCTION_URL"
echo ""
echo "Test dengan curl:"
echo "curl -i $FUNCTION_URL"
echo ""
echo "Atau buka di browser:"
echo "$FUNCTION_URL"
echo "=========================================="

# Cleanup
rm function.zip
