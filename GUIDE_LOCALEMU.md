# Panduan Lengkap - LocalEmu + WSL 2 Ubuntu

## 📋 Ringkasan

Setup ini menggunakan **LocalEmu** - emulator AWS open-source yang mensimulasikan 133+ layanan AWS secara lokal tanpa perlu akun AWS.

### Layanan yang Didukung:
- ✅ **AWS Lambda** - Fungsi serverless
- ✅ **EC2** - Virtual machine
- ✅ **RDS** - Database (MySQL, PostgreSQL)
- ✅ S3, DynamoDB, IAM, API Gateway, dan 120+ layanan lainnya

### Keuntungan:
- 🆓 **Gratis** - Tidak perlu akun AWS
- 🔒 **Aman** - Data tetap di lokal
- ⚡ **Cepat** - Iterasi dalam hitungan detik
- 🔄 **Real Runtime** - Lambda berjalan di container AWS asli

---

## 🗂️ Struktur Folder

```
aws-lambda-practicum/
├── config/                          # Konfigurasi AWS
│   ├── aws-credentials.example      # Template credentials
│   ├── aws-config.example          # Template config
│   ├── ec2/                        # Konfigurasi EC2
│   │   └── instance-config.tf      # Terraform EC2
│   └── rds/                        # Konfigurasi RDS
│       └── database-config.tf      # Terraform RDS
├── index.mjs                       # Lambda handler
├── index.html                      # HTML template
├── local_server.mjs                # Simulator lokal sederhana
├── localemu-setup.sh               # Setup LocalEmu
├── deploy-lambda-localemu.sh       # Deploy Lambda ke LocalEmu
├── delete-lambda-localemu.sh       # Delete Lambda (confirm & delete)
├── docker-compose.yml              # Docker Compose untuk semua service
├── Dockerfile                      # Docker image untuk Lambda
└── package.json                    # Node.js dependencies
```

---

## 🚀 Cara Setup (Langkah Demi Langkah)

### Langkah 1: Setup LocalEmu (Emulator AWS)

#### Option A: Menggunakan Script (Rekomendasi)
```bash
# Dari WSL 2 Ubuntu terminal:
cd "/mnt/c/laragon/www/aws-lambda-practicum"
chmod +x localemu-setup.sh
bash localemu-setup.sh
```

#### Option B: Menggunakan Docker Compose
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
docker-compose up -d localemu
```

#### Option C: Manual Docker Run
```bash
docker run --rm -d --name localemu \
    -p 4566:4566 \
    -p 4510-4559:4510-4559 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --group-add docker \
    -e DASHBOARD_API_OPEN=1 \
    -e PERSISTENCE=1 \
    -v localemu-data:/var/lib/localemu \
    localemu/localemu:latest
```

### Langkah 2: Cek LocalEmu Berjalan
```bash
curl http://localhost:4566/_localemu/health
```

Expected output: `{"status":"ok"}`

### Langkah 3: Buka Dashboard LocalEmu
Buka browser: **http://localhost:4566/_localemu/dashboard**

Dashboard menampilkan:
- Status semua layanan
- Resource counts
- Activity feed real-time
- S3 browser, DynamoDB viewer, dll

---

## 📦 Deploy Lambda Function ke LocalEmu

### Langkah 1: Setup AWS CLI Environment
```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
```

### Langkah 2: Deploy Lambda (Menggunakan Script)
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
chmod +x deploy-lambda-localemu.sh
bash deploy-lambda-localemu.sh
```

Script ini akan:
1. Membuat IAM role untuk Lambda
2. Membuat ZIP deployment package
3. Create Lambda function
4. Create Function URL
5. Menampilkan Function URL

### Langkah 3: Test Lambda Function
```bash
# Dapatkan Function URL
FUNCTION_URL=$(aws lambda get-function-url-config \
    --function-name lambda-wsl-tutorial \
    --query FunctionUrl \
    --output text)

# Test dengan curl
curl -i $FUNCTION_URL
```

Atau buka Function URL di browser.

---

## 🗑️ Simulasi "Confirm & Delete" (Sesuai Video)

### Menggunakan Script:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
chmod +x delete-lambda-localemu.sh
bash delete-lambda-localemu.sh
```

Script ini akan:
1. Meminta ketik "confirm" untuk delete Function URL
2. Meminta ketik nama function untuk delete function
3. Menghapus Function URL dan Lambda function

### Manual Delete:
```bash
# Delete Function URL
aws lambda delete-function-url-config \
    --function-name lambda-wsl-tutorial

# Delete Lambda function
aws lambda delete-function \
    --function-name lambda-wsl-tutorial
```

---

## 🔧 Konfigurasi AWS Credentials

### Option A: Environment Variables (Untuk LocalEmu)
```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
```

### Option B: AWS Credentials File
```bash
# Copy template
cp config/aws-credentials.example config/aws-credentials

# Edit file
nano config/aws-credentials
```

Lalu di AWS CLI:
```bash
export AWS_SHARED_CREDENTIALS_FILE=/mnt/c/laragon/www/Pert\ 5\ -\ Lambda/config/aws-credentials
aws configure --profile local
```

### Option C: AWS Config File
```bash
# Copy template
cp config/aws-config.example config/aws-config

# Edit file
nano config/aws-config
```

---

## 🖥️ Setup EC2 Instance (Terraform)

### Prasyarat:
- Terraform terinstall di WSL 2
- LocalEmu berjalan

### Langkah:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum/config/ec2"

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply deployment
terraform apply

# Lihat output
terraform output
```

### Hapus EC2:
```bash
terraform destroy
```

---

## 🗄️ Setup RDS Database (Terraform)

### Prasyarat:
- Terraform terinstall di WSL 2
- LocalEmu berjalan

### Langkah:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum/config/rds"

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply deployment
terraform apply

# Lihat output
terraform output
```

### Connect ke RDS:
```bash
# Dapatkan endpoint
RDS_ENDPOINT=$(terraform output -raw rds_endpoint)

# Connect dengan MySQL client
mysql -h $RDS_ENDPOINT -P 3306 -u admin -p lambda_db
```

### Hapus RDS:
```bash
terraform destroy
```

---

## 🐳 Menggunakan Docker Compose (Semua Service)

### Jalankan Semua Service:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
docker-compose up -d
```

Ini akan menjalankan:
- **localemu** - AWS emulator
- **mysql** - Database RDS simulation
- **lambda-web** - Web server lokal

### Cek Status:
```bash
docker-compose ps
```

### Lihat Logs:
```bash
# Logs semua service
docker-compose logs

# Logs spesifik service
docker-compose logs localemu
docker-compose logs mysql
docker-compose logs lambda-web
```

### Stop Semua Service:
```bash
docker-compose down
```

### Stop dan Hapus Volume:
```bash
docker-compose down -v
```

---

## 📊 Monitoring & Debugging

### Cek LocalEmu Dashboard:
**http://localhost:4566/_localemu/dashboard**

### Cek Lambda Logs:
```bash
aws logs tail /aws/lambda/lambda-wsl-tutorial \
    --follow \
    --format short
```

### Cek CloudTrail Events:
```bash
aws cloudtrail lookup-events \
    --lookup-attributes AttributeKey=ResourceName,AttributeValue=lambda-wsl-tutorial
```

### List Lambda Functions:
```bash
aws lambda list-functions
```

### List EC2 Instances:
```bash
aws ec2 describe-instances
```

### List RDS Instances:
```bash
aws rds describe-db-instances
```

---

## 🔀 Switch Antara LocalEmu dan AWS Asli

### Untuk LocalEmu (Default untuk praktikum):
```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
```

### Untuk AWS Asli (Production):
```bash
unset AWS_ENDPOINT_URL
export AWS_ACCESS_KEY_ID=YOUR_REAL_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_REAL_SECRET_KEY
export AWS_DEFAULT_REGION=ap-southeast-3
```

### Menggunakan AWS Profiles:
```bash
# LocalEmu
aws --profile local s3 ls

# AWS Asli
aws --profile default s3 ls
```

---

## 🧪 Testing & Bukti Tugas

### Test 1: Lambda Function Berjalan
```bash
# Deploy
bash deploy-lambda-localemu.sh

# Test
curl -i http://localhost:4566/restapis/.../Prod/_user_request_/lambda-wsl-tutorial
```

**Screenshot**: Browser yang menampilkan "Hello from AWS Lambda!"

### Test 2: Function URL Aktif
```bash
aws lambda get-function-url-config \
    --function-name lambda-wsl-tutorial
```

**Screenshot**: Output Function URL

### Test 3: Delete Function URL (Ketik "confirm")
```bash
bash delete-lambda-localemu.sh
```

**Screenshot**:
1. Terminal yang menunjukkan prompt "confirm"
2. Setelah delete, coba akses URL → akan muncul error

### Test 4: EC2 Instance (Opsional)
```bash
cd config/ec2
terraform apply
```

**Screenshot**: Terraform output dengan instance ID

### Test 5: RDS Database (Opsional)
```bash
cd config/rds
terraform apply
```

**Screenshot**: Terraform output dengan database endpoint

---

## 📝 Catatan Penting

### LocalEmu vs AWS Asli:

| Fitur | LocalEmu | AWS Asli |
|-------|----------|----------|
| Biaya | Gratis | Per usage |
| Data Persistence | Lokal | Cloud |
| Latency | < 1ms | Regional |
| Access | Local | Global |
| Auth | Simulasi | Real IAM |

### Limitations LocalEmu:
- Tidak semua fitur AWS didukung 100%
- Beberapa layanan simulasi (tidak real backend)
- Tidak untuk production use

### Best Practices:
1. Gunakan LocalEmu untuk development & testing
2. Gunakan AWS asli untuk production
3. Jangan gunakan credentials fake di production
4. Jangan commit credentials ke git
5. Gunakan environment variables untuk sensitive data

---

## 🆘 Troubleshooting

### LocalEmu tidak start:
```bash
# Cek Docker daemon
docker ps

# Cek logs
docker logs localemu

# Restart Docker di WSL 2
sudo service docker restart
```

### Lambda deployment error:
```bash
# Cek LocalEmu health
curl http://localhost:4566/_localemu/health

# Cek IAM role
aws iam list-roles

# Cek function
aws lambda list-functions
```

### Port conflict:
```bash
# Cek port yang digunakan
netstat -tulpn | grep :4566

# Stop service yang menggunakan port
sudo kill -9 <PID>
```

### Terraform error:
```bash
# Re-initialize
terraform init -reconfigure

# Refresh state
terraform refresh

# Clear cache
rm -rf .terraform
```

---

## 📚 Referensi

- [LocalEmu Documentation](https://localemu.cloud/docs)
- [LocalEmu GitHub](https://github.com/localemu/localemu)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

---

## ✅ Checklist Tugas

- [ ] LocalEmu berjalan (docker ps)
- [ ] Lambda function deployed
- [ ] Function URL bisa diakses dari browser
- [ ] Menampilkan "Hello from AWS Lambda!"
- [ ] Simulasi delete dengan ketik "confirm"
- [ ] Screenshot bukti semua langkah
- [ ] (Opsional) EC2 instance via Terraform
- [ ] (Opsional) RDS database via Terraform

---

**Status**: ✅ Setup Siap Digunakan
