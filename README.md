# Lambda-Localstack-Lab
<sub><span style="opacity: 0.85">Panduan praktikum AWS Lambda tanpa akun AWS - LocalStack, Terraform, dan emulator lokal.</span></sub>
<div align="center" style="font-size: 0.9em">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="130px" />
</div>

[![CI](https://github.com/devarent/lambda-localstack-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/devarent/lambda-localstack-lab/actions/workflows/ci.yml)

---


<!-- identity-block -->
<div align="center">

# lambda-localstack-lab

<sub>Panduan praktikum AWS Lambda tanpa akun AWS - LocalStack, Terraform, dan emulator lokal.</sub>

</div>

## At a glance

| Field | Detail |
| --- | --- |
| Repository | lambda-localstack-lab |
| Primary language | Shell |
| Topics | aws, docker, lambda, localstack, praktikum, serverless, shell, terraform |
| License | MIT |
| Branch | main |
| Maintainer | [@devarent](https://github.com/devarent) |

## Overview

lambda-localstack-lab is a hands-on repository focused on: Panduan praktikum AWS Lambda tanpa akun AWS - LocalStack, Terraform, dan emulator lokal.. Primary language: Shell. Topics: aws, docker, lambda, localstack, praktikum, serverless, shell, terraform. The README below documents the project; use the table above for a quick overview.

### Global references

<div align="center">

🇮🇸 Iceland &middot; 🇳🇿 New Zealand &middot; 🇨🇭 Switzerland &middot; 🇸🇮 Slovenia &middot; 🇮🇪 Ireland &middot; 🇦🇹 Austria &middot; 🇵🇹 Portugal &middot; 🇸🇬 Singapore &middot; 🇫🇮 Finland

</div>

---

<!-- dbx-style-kit -->
<div align="center">

<img src="https://img.shields.io/badge/lambda-localstack-lab-1f6feb?style=for-the-badge" alt="lambda-localstack-lab" />
<img src="https://img.shields.io/badge/LANG%20Shell-3178c6?style=for-the-badge" alt="LANG Shell" />
<img src="https://img.shields.io/badge/STARS%200-eab308?style=for-the-badge" alt="STARS 0" />
<img src="https://img.shields.io/badge/LICENSE%20MIT-22c55e?style=for-the-badge" alt="LICENSE MIT" />

<br>

<img src="https://img.shields.io/badge/OPEN%20SOURCE-yes-22c55e?style=for-the-badge&logo=github&logoColor=white" alt="OPEN SOURCE" />
<img src="https://img.shields.io/badge/BUILT%20IN%20PUBLIC-true-6366f1?style=for-the-badge&logo=opensourceinitiative&logoColor=white" alt="BUILT IN PUBLIC" />
<img src="https://img.shields.io/badge/HANDS%20ON%20LABS-52-0ea5e9?style=for-the-badge&logo=docker&logoColor=white" alt="HANDS ON LABS" />
<img src="https://img.shields.io/badge/DOCUMENTED-yes-14b8a6?style=for-the-badge&logo=markdown&logoColor=white" alt="DOCUMENTED" />

<br>

<b>Panduan praktikum AWS Lambda tanpa akun AWS - LocalStack, Terraform, dan emulator lokal.</b>

</div>

---
# PANDUAN LENGKAP & PRAKTIKUM PERT 5: AWS LAMBDA TANPA AKUN AWS
**Mata Kuliah**: Komputasi Awan (Cloud Computing)  
**Materi**: Pertemuan 5 - AWS Lambda (Serverless Web App & Function URL)  
**Metode**: Simulasi Lokal Menggunakan Docker / Node.js di WSL 2 (Ubuntu / Kali Linux)  

---

## 1. Menjawab Masalah: "Saya Tidak Punya Akun AWS & Token AI Habis, File-nya Masuk ke Mana di Ubuntu?"

### A. Lokasi File di Ubuntu (WSL 2)
Anda **TIDAK PERLU repot memindahkan file**!  
Windows dan Ubuntu WSL 2 sudah terhubung langsung melalui folder mount `/mnt/c/`.

* **Di Windows**: `C:\laragon\www\aws-lambda-practicum`
* **Di Ubuntu WSL 2**: `/mnt/c/laragon/www/aws-lambda-practicum`

Cukup buka terminal Ubuntu Anda, lalu ketik:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
ls -la
```
Semua file (`index.mjs`, `index.html`, `Dockerfile`, dll.) sudah langsung ada di sana!

---

## 2. Cara Menjalankan Tugas Tanpa Akun AWS

Dosen Anda di video mendemokan 2 hal utama:
1. **Status Aktif**: Membuka link Function URL dan melihat halaman web **"Hello from AWS Lambda!"**.
2. **Status Hapus (Delete & Confirm)**: Menghapus Function URL dengan mengetik **"confirm"**, sehingga saat halaman direfresh muncul tulisan JSON: **`{"Message":null}`** (lihat video menit 10:18 - 10:31).

Anda bisa mereplikasi seluruh tahapan ini 100% di Ubuntu WSL 2 dengan simulator yang sudah saya siapkan:

### Langkah A: Menjalankan di Terminal Ubuntu WSL 2
Buka terminal Ubuntu WSL 2:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
node local_server.mjs
```
*(Atau menggunakan Docker: `docker build -t lambda-pert5 . && docker run -it --rm -p 9000:9000 lambda-pert5`)*

---

### Langkah B: Pengujian 1 - Halaman "Hello from AWS Lambda!" (Aktif)
1. Buka browser di laptop Anda (Chrome/Edge/Firefox).
2. Akses alamat:
   ```
   http://localhost:9000
   ```
3. **Hasil**: Halaman web bertuliskan **"Hello from AWS Lambda! The blueprint function you created rendered this page"** akan tampil persis seperti di video dosen menit 08:26.
4. **Screenshot 1**: Ambil tangkapan layar ini untuk bukti tugas pertama Anda.

---

### Langkah C: Pengujian 2 - Simulasi Hapus Function URL ("confirm" & "delete")
1. Kembali ke terminal Ubuntu yang sedang menjalankan `local_server.mjs`.
2. Ketik kata:
   ```
   confirm
   ```
   lalu tekan **ENTER**.
3. Di terminal akan muncul notifikasi bahwa Function URL telah dihapus.
4. Kembali ke browser Anda dan **REFRESH halaman `http://localhost:9000`**.
5. **Hasil**: Halaman akan menampilkan teks:
   ```json
   {"Message":null}
   ```
   Tampilan ini **identik 100% dengan video dosen menit 10:31** saat Function URL sudah dihapus!
6. **Screenshot 2**: Ambil tangkapan layar browser ini dan tangkapan layar terminal Anda saat mengetik `confirm` sebagai bukti tugas kedua.

---

## 3. Jika Ingin Menggunakan Docker Resmi AWS Lambda (RIE)
Jika dosen mengharuskan penggunaan Docker base image resmi AWS (`public.ecr.aws/lambda/nodejs:20`):

1. **Jalankan container**:
   ```bash
   cd "/mnt/c/laragon/www/aws-lambda-practicum"
   docker build -t lambda-lokal .
   docker run --rm -p 9000:9000 lambda-lokal
   ```
2. **Uji dari terminal kedua menggunakan curl**:
   ```bash
   curl -i http://localhost:9000
   ```

---

## 4. Struktur File di Folder Praktikum Ini

- [index.mjs](file:///c:/laragon/www/Pert%205%20-%20Lambda/index.mjs): Handler fungsi AWS Lambda (Node.js ES Module).
- [index.html](file:///c:/laragon/www/Pert%205%20-%20Lambda/index.html): Template halaman *"Hello from AWS Lambda!"*.
- [local_server.mjs](file:///c:/laragon/www/Pert%205%20-%20Lambda/local_server.mjs): Simulator runtime HTTP AWS Lambda untuk pengujian lokal di Windows/WSL2/Linux.
- [Dockerfile](file:///c:/laragon/www/Pert%205%20-%20Lambda/Dockerfile): Konfigurasi Docker container jika ingin dijalankan di Docker WSL 2.
- [confirm_delete.sh](file:///c:/laragon/www/Pert%205%20-%20Lambda/confirm_delete.sh): Script simulasi "confirm & delete" sesuai video.
- [test_lambda.sh](file:///c:/laragon/www/Pert%205%20-%20Lambda/test_lambda.sh): Script bash untuk testing via `curl` di terminal Kali Linux / Ubuntu.
- [package.json](file:///c:/laragon/www/Pert%205%20-%20Lambda/package.json): Definisi paket Node.js.

---

## 5. Panduan Alternatif: Jalankan Tanpa Akun AWS (Solusi Lengkap)

### Masalah: Token AWS habis, tidak bisa akses AWS Console?
Jika akun AWS Anda sudah habis kuotanya atau tidak bisa login, Anda tetap bisa menyelesaikan tugas ini dengan menjalankan Lambda function **secara lokal** di Ubuntu/WSL 2 menggunakan Node.js atau Docker.

### Solusi A: Jalankan Langsung dengan Node.js (Rekomendasi - Paling Mudah)

#### Di Windows:
1. Pastikan Node.js sudah terinstall (cek dengan `node --version`)
2. Buka terminal di folder proyek:
   ```bash
   cd "C:\laragon\www\aws-lambda-practicum"
   ```
3. Jalankan server lokal:
   ```bash
   npm start
   # atau:
   node local_server.mjs
   ```
4. Buka browser: `http://localhost:9000`
5. Output akan sama persis dengan AWS Lambda!

#### Di WSL 2 (Ubuntu/Kali Linux):
1. Buka terminal WSL 2
2. Masuk ke folder proyek:
   ```bash
   cd "/mnt/c/laragon/www/aws-lambda-practicum"
   ```
3. Pastikan Node.js terinstall:
   ```bash
   node --version
   # Jika belum, install: sudo apt update && sudo apt install nodejs npm
   ```
4. Jalankan server:
   ```bash
   node local_server.mjs
   ```
5. Test dari terminal lain:
   ```bash
   curl -i http://localhost:9000
   ```

### Solusi B: Jalankan dengan Docker Container

#### Di WSL 2 (Ubuntu/Kali Linux):
1. Pastikan Docker sudah terinstall dan berjalan:
   ```bash
   docker --version
   docker ps
   ```
2. Build image:
   ```bash
   cd "/mnt/c/laragon/www/aws-lambda-practicum"
   docker build -t lambda-lokal .
   ```
3. Jalankan container:
   ```bash
   docker run -d -p 9000:9000 --name lambda-container lambda-lokal
   ```
4. Test:
   ```bash
   curl -i http://localhost:9000
   ```
5. Lihat logs:
   ```bash
   docker logs lambda-container
   ```

### Solusi C: Simulasi "Confirm & Delete" (Sesuai Video)

Script `confirm_delete.sh` mensimulasikan proses menghapus Function URL dan Lambda function seperti di video:

```bash
# Dari WSL 2 / Ubuntu:
cd "/mnt/c/laragon/www/aws-lambda-practicum"
chmod +x confirm_delete.sh
./confirm_delete.sh
```

Script ini akan:
1. Meminta Anda mengetik "confirm" untuk simulasi delete Function URL
2. Meminta Anda mengetik nama function untuk simulasi delete function
3. Menampilkan informasi cara menghentikan server lokal (sesuai environment Anda)

### Apa Perbedaannya dengan AWS Asli?

| Fitur | AWS Lambda Asli | Setup Lokal (Tanpa Akun) |
|-------|----------------|------------------------|
| Function URL | HTTPS endpoint public | http://localhost:9000 |
| Runtime | AWS managed runtime | Node.js di komputer Anda |
| Biaya | Per milidetik eksekusi | Gratis (resource lokal) |
| Scalability | Auto-scale | 1 instance saja |
| Delete | Ketik "confirm" di console | Stop server/Ctrl+C |
| Tujuan | Production | Development/Learning |

### Output yang Sama

Baik di AWS asli maupun lokal, output akan **identik**:
- HTML dengan "Hello from AWS Lambda!"
- Pesan "Hello from AWS Lambda in Kali Linux Ubuntu WSL 2"
- Informasi request (method, path, user agent, timestamp)
- Styling yang sama persis

### Bukti untuk Tugas

Untuk membuktikan ke dosen bahwa Anda telah menyelesaikan tugas:

1. **Screenshot output HTML** dari browser (localhost:9000)
2. **Screenshot terminal** yang menunjukkan server berjalan
3. **Screenshot curl** dari WSL 2 yang menampilkan HTTP 200
4. **Screenshot script confirm_delete.sh** yang menunjukkan simulasi delete

Semua ini bisa dilakukan **tanpa akun AWS**!

---

## 6. Format Laporan yang Dikumpulkan ke Edlink
Gunakan file [LAPORAN_TUGAS_EDLINK.md](file:///c:/laragon/www/Pert%205%20-%20Lambda/LAPORAN_TUGAS_EDLINK.md) yang sudah tersedia di folder ini. Cukup masukkan Nama, NIM, dan tempelkan tangkapan layar hasil pengujian di atas.

---

## 7. Setup Menggunakan LocalEmu (Full AWS Emulator - Rekomendasi)

LocalEmu adalah emulator AWS open-source yang mensimulasikan 133+ layanan AWS (Lambda, EC2, RDS, S3, dll) secara lokal tanpa perlu akun AWS.

### Keuntungan LocalEmu:
- ✅ Mensimulasikan Lambda dengan **real AWS runtime images**
- ✅ Mendukung EC2, RDS, S3, DynamoDB, dan 120+ layanan lainnya
- ✅ Gratis, tidak perlu akun AWS
- ✅ Dashboard web untuk monitoring real-time
- ✅ Persistence data (bisa disimpan antar restart)
- ✅ IAM enforcement (opsional)

### Cara Setup LocalEmu:

#### Option A: Menggunakan Script (Rekomendasi)
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
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

### Cek LocalEmu Berjalan:
```bash
curl http://localhost:4566/_localemu/health
```

### Buka Dashboard LocalEmu:
**http://localhost:4566/_localemu/dashboard**

Dashboard menampilkan:
- Status semua layanan AWS
- Resource counts (Lambda functions, S3 buckets, EC2 instances, dll)
- Activity feed real-time
- S3 object browser
- DynamoDB item viewer
- CloudTrail event history

### Deploy Lambda ke LocalEmu:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
bash deploy-lambda-localemu.sh
```

Script ini akan:
1. Membuat IAM role untuk Lambda
2. Membuat ZIP deployment package
3. Create Lambda function
4. Create Function URL
5. Menampilkan Function URL untuk testing

### Test Lambda:
```bash
# Get Function URL
aws lambda get-function-url-config \
    --function-name lambda-wsl-tutorial \
    --query FunctionUrl \
    --output text

# Test dengan curl
curl -i <FUNCTION_URL>
```

### Simulasi Delete (Confirm & Delete):
```bash
bash delete-lambda-localemu.sh
```

Script ini akan:
1. Meminta ketik "confirm" untuk delete Function URL
2. Meminta ketik nama function untuk delete function
3. Menghapus Function URL dan Lambda function

### Dokumentasi Lengkap:
Lihat file **GUIDE_LOCALEMU.md** untuk panduan lengkap:
- Setup LocalEmu
- Deploy Lambda function
- Setup EC2 dengan Terraform
- Setup RDS dengan Terraform
- Konfigurasi AWS credentials
- Monitoring & debugging
- Troubleshooting

---

## 8. Struktur Folder & Konfigurasi

### Folder Utama:
```
aws-lambda-practicum/
├── config/                          # Konfigurasi AWS (pisah)
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
├── setup-wsl.sh                    # Menu setup WSL 2
├── GUIDE_LOCALEMU.md               # Panduan lengkap LocalEmu
├── PANDUAN_SETUP.md                # Panduan setup AWS Console
├── README.md                       # File ini
└── LAPORAN_TUGAS_EDLINK.md         # Template laporan
```

### Konfigurasi AWS (Di Folder config/):
- **aws-credentials.example** - Template untuk AWS credentials (LocalEmu dan AWS asli)
- **aws-config.example** - Template untuk AWS config (profiles untuk berbagai layanan)
- **ec2/instance-config.tf** - Terraform untuk EC2 instance
- **rds/database-config.tf** - Terraform untuk RDS database

### Cara Menggunakan Konfigurasi:
```bash
# Copy template
cp config/aws-credentials.example config/aws-credentials
cp config/aws-config.example config/aws-config

# Edit file sesuai kebutuhan
nano config/aws-credentials
nano config/aws-config
```

### Setup EC2 dengan Terraform:
```bash
cd config/ec2
terraform init
terraform plan
terraform apply
```

### Setup RDS dengan Terraform:
```bash
cd config/rds
terraform init
terraform plan
terraform apply
```

---

## 9. Menu Setup Cepat

Gunakan script `setup-wsl.sh` untuk memilih metode setup:

```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
bash setup-wsl.sh
```

Pilihan:
1. **LocalEmu** - Full AWS Emulator (133+ layanan)
2. **Docker Simple** - Hanya Lambda simulator
3. **Buka panduan** - Lihat dokumentasi lengkap

---

## 10. Perbandingan Metode

| Metode | Layanan | Complexity | Rekomendasi |
|--------|---------|------------|-------------|
| **LocalEmu** | 133+ layanan (Lambda, EC2, RDS, S3, dll) | Medium | ✅ Best untuk praktikum lengkap |
| **Docker Simple** | Hanya Lambda simulator | Low | ✅ Best untuk tugas Lambda saja |
| **Node.js Direct** | Hanya Lambda simulator | Very Low | ❌ Tidak mensimulasikan AWS environment |

---

## 11. Link Penting

- [LocalEmu Documentation](https://localemu.cloud/docs)
- [LocalEmu GitHub](https://github.com/localemu/localemu)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [Docker Hub - LocalEmu](https://hub.docker.com/r/localemu/localemu)
- [AWS Builder Center - Run Lambda Locally](https://builder.aws.com/content/3EdXXOR8w0AxTVeyUh8m7Bm5qxo/run-real-aws-lambda-on-your-laptop)

---

## Project Governance

[![CI](https://github.com/devarent/lambda-localstack-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/devarent/lambda-localstack-lab/actions/workflows/ci.yml)

[Contributing](CONTRIBUTING.md) | [Security Policy](SECURITY.md) | [Code of Conduct](CODE_OF_CONDUCT.md)

---

<!-- tech-stack-wall -->
## Tech Stack

<div align="center">

<img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git" />

</div>

<details>
<summary><b>Full Tech Stack Wall</b></summary>
<br>

<div align="center">

<b>Languages</b><br>
<img src="https://img.shields.io/badge/Rust-dea584?style=for-the-badge&logo=rust&logoColor=black" alt="Rust" />
<img src="https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white" alt="Go" />
<img src="https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black" alt="JavaScript" />
<img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java" />
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
<img src="https://img.shields.io/badge/C-A8B9CC?style=for-the-badge&logo=c&logoColor=black" alt="C" />
<img src="https://img.shields.io/badge/C%2B%2B-00599C?style=for-the-badge&logo=cplusplus&logoColor=white" alt="C++" />
<img src="https://img.shields.io/badge/Kotlin-7F52FF?style=for-the-badge&logo=kotlin&logoColor=white" alt="Kotlin" />
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift" />
<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white" alt="Ruby" />
<img src="https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white" alt="PHP" />
<img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua" />
<img src="https://img.shields.io/badge/Shell-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" alt="Shell" />
<br><br>
<b>Frontend &amp; Desktop</b><br>
<img src="https://img.shields.io/badge/Vue-4FC08D?style=for-the-badge&logo=vuedotjs&logoColor=black" alt="Vue" />
<img src="https://img.shields.io/badge/React-61DAFB?style=for-the-badge&logo=react&logoColor=black" alt="React" />
<img src="https://img.shields.io/badge/Svelte-FF3E00?style=for-the-badge&logo=svelte&logoColor=white" alt="Svelte" />
<img src="https://img.shields.io/badge/Next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white" alt="Next.js" />
<img src="https://img.shields.io/badge/Nuxt-00DC82?style=for-the-badge&logo=nuxtdotjs&logoColor=black" alt="Nuxt" />
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
<img src="https://img.shields.io/badge/React%20Native-61DAFB?style=for-the-badge&logo=react&logoColor=black" alt="React Native" />
<img src="https://img.shields.io/badge/Tauri-FFC131?style=for-the-badge&logo=tauri&logoColor=black" alt="Tauri" />
<img src="https://img.shields.io/badge/Electron-47848F?style=for-the-badge&logo=electron&logoColor=white" alt="Electron" />
<img src="https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white" alt="Vite" />
<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5" />
<img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white" alt="CSS3" />
<img src="https://img.shields.io/badge/Sass-CC6699?style=for-the-badge&logo=sass&logoColor=white" alt="Sass" />
<img src="https://img.shields.io/badge/Less-1D365D?style=for-the-badge&logo=less&logoColor=white" alt="Less" />
<img src="https://img.shields.io/badge/Tailwind%20CSS-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white" alt="Tailwind CSS" />
<img src="https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white" alt="Bootstrap" />
<img src="https://img.shields.io/badge/Three.js-000000?style=for-the-badge&logo=threedotjs&logoColor=white" alt="Three.js" />
<img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js" />
<img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white" alt="jQuery" />
<br><br>
<b>Database &amp; Storage</b><br>
<img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
<img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
<img src="https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite" />
<img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="SQL Server" />
<img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white" alt="Oracle" />
<img src="https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white" alt="Redis" />
<img src="https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white" alt="MongoDB" />
<img src="https://img.shields.io/badge/DuckDB-FFCB00?style=for-the-badge&logo=duckdb&logoColor=black" alt="DuckDB" />
<img src="https://img.shields.io/badge/ClickHouse-FFCC00?style=for-the-badge&logo=clickhouse&logoColor=black" alt="ClickHouse" />
<img src="https://img.shields.io/badge/Elasticsearch-005571?style=for-the-badge&logo=elasticsearch&logoColor=white" alt="Elasticsearch" />
<img src="https://img.shields.io/badge/Neo4j-008CC1?style=for-the-badge&logo=neo4j&logoColor=white" alt="Neo4j" />
<img src="https://img.shields.io/badge/InfluxDB-22ADF6?style=for-the-badge&logo=influxdb&logoColor=white" alt="InfluxDB" />
<img src="https://img.shields.io/badge/Cassandra-1287B1?style=for-the-badge&logo=apachecassandra&logoColor=white" alt="Cassandra" />
<img src="https://img.shields.io/badge/DynamoDB-4053D6?style=for-the-badge&logo=amazondynamodb&logoColor=white" alt="DynamoDB" />
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
<img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=black" alt="Supabase" />
<img src="https://img.shields.io/badge/MinIO-C72E49?style=for-the-badge&logo=minio&logoColor=white" alt="MinIO" />
<br><br>
<b>Messaging &amp; Streaming</b><br>
<img src="https://img.shields.io/badge/Kafka-231F20?style=for-the-badge&logo=apachekafka&logoColor=white" alt="Kafka" />
<img src="https://img.shields.io/badge/RabbitMQ-FF6600?style=for-the-badge&logo=rabbitmq&logoColor=white" alt="RabbitMQ" />
<img src="https://img.shields.io/badge/RocketMQ-FF6A00?style=for-the-badge&logoColor=white" alt="RocketMQ" />
<img src="https://img.shields.io/badge/Pulsar-188FFF?style=for-the-badge&logo=apachepulsar&logoColor=white" alt="Pulsar" />
<img src="https://img.shields.io/badge/Flink-E6526F?style=for-the-badge&logo=apacheflink&logoColor=white" alt="Flink" />
<br><br>
<b>DevOps &amp; Cloud Native</b><br>
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
<img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes" />
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
<img src="https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white" alt="Ansible" />
<img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white" alt="Jenkins" />
<img src="https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions" />
<img src="https://img.shields.io/badge/GitLab%20CI-FC6D26?style=for-the-badge&logo=gitlab&logoColor=white" alt="GitLab CI" />
<img src="https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white" alt="Prometheus" />
<img src="https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white" alt="Grafana" />
<img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white" alt="Nginx" />
<img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white" alt="AWS" />
<img src="https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white" alt="Azure" />
<img src="https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=cloudflare&logoColor=white" alt="Cloudflare" />
<br><br>
<b>Tools &amp; Platforms</b><br>
<img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git" />
<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux" />
<img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS" />
<img src="https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white" alt="VS Code" />
<img src="https://img.shields.io/badge/Vim-019733?style=for-the-badge&logo=vim&logoColor=white" alt="Vim" />
<img src="https://img.shields.io/badge/Tmux-1BB91F?style=for-the-badge&logoColor=white" alt="Tmux" />
<img src="https://img.shields.io/badge/Homebrew-FAB316?style=for-the-badge&logo=homebrew&logoColor=black" alt="Homebrew" />
<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white" alt="Postman" />
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white" alt="Figma" />
<img src="https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white" alt="Markdown" />
<img src="https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white" alt="Maven" />
<img src="https://img.shields.io/badge/Gradle-02303A?style=for-the-badge&logo=gradle&logoColor=white" alt="Gradle" />
<img src="https://img.shields.io/badge/CMake-064F8C?style=for-the-badge&logo=cmake&logoColor=white" alt="CMake" />

</div>
</details>

<div align="center">
<sub>Hands-on engineering, built and documented in the open.</sub>
</div>