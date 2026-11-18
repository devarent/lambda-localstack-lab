# Panduan Setup GitHub untuk Proyek Ini

## 📋 Langkah-langkah:

### 1. Buat Repository di GitHub

1. Buka browser dan kunjungi: https://github.com/new
2. Login dengan akun GitHub Anda: `aryafatthurahman4-collab`
3. Isi form:
   - **Repository name**: `pert-5-lambda`
   - **Description**: AWS Lambda Praktikum Pertemuan 5 - Cloud Computing
   - **Visibility**: Public (atau Private jika mau)
   - **JANGAN centang** "Add a README file" (karena sudah ada di proyek)
   - **JANGAN centang** "Add .gitignore" (sudah ada)
   - **JANGAN centang** "Choose a license" (opsional)
4. Klik **Create repository**

### 2. Push ke GitHub (Setelah Repository Dibuat)

#### Option A: Menggunakan HTTPS (Dengan Personal Access Token)
```bash
cd "C:\laragon\www\aws-lambda-practicum"
git remote set-url origin https://github.com/aryafatthurahman4-collab/pert-5-lambda.git
git push -u origin main
```

Jika diminta username & password:
- **Username**: `aryafatthurahman4-collab`
- **Password**: Gunakan **Personal Access Token (PAT)**

#### Cara Membuat Personal Access Token:
1. Buka: https://github.com/settings/tokens
2. Klik **Generate new token** → **Generate new token (classic)**
3. Beri nama: "Git Push Token"
4. Centang permissions:
   - ✅ repo (full control of private repositories)
   - ✅ workflow (untuk GitHub Actions)
5. Klik **Generate token**
6. **Copy token** (hanya muncul sekali!)
7. Gunakan token sebagai password saat git push

#### Option B: Menggunakan SSH (Jika sudah setup SSH key)
```bash
cd "C:\laragon\www\aws-lambda-practicum"
git remote set-url origin git@github.com:aryafatthurahman4-collab/pert-5-lambda.git
git push -u origin main
```

### 3. Verifikasi di GitHub

Setelah berhasil push:
1. Buka: https://github.com/aryafatthurahman4-collab/pert-5-lambda
2. Pastikan semua file sudah muncul
3. GitHub Actions akan otomatis berjalan (lihat tab "Actions")

### 4. GitHub Actions CI/CD

Proyek ini sudah dilengkapi dengan GitHub Actions workflow yang akan:
- ✅ Test local server dengan Node.js
- ✅ Build dan test Docker image
- ✅ Test dengan LocalEmu (AWS emulator)
- ✅ Jalankan otomatis setiap push ke main branch

Lihat progress di: https://github.com/aryafatthurahman4-collab/pert-5-lambda/actions

---

## 🔧 Troubleshooting

### Error: "Repository not found"
- Pastikan repository sudah dibuat di GitHub
- Pastikan nama repository benar: `pert-5-lambda`
- Pastikan username benar: `aryafatthurahman4-collab`

### Error: "Authentication failed"
- Gunakan Personal Access Token (PAT) bukan password GitHub
- Pastikan token memiliki permission `repo` dan `workflow`

### Error: "Permission denied (publickey)"
- Setup SSH key: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
- Atau gunakan HTTPS dengan PAT

---

## 📊 Setelah Setup Selesai

Repository Anda akan memiliki:
- ✅ Source code lengkap
- ✅ GitHub Actions CI/CD otomatis
- ✅ Dokumentasi lengkap (README, GUIDE_LOCALEMU.md)
- ✅ Konfigurasi Terraform untuk EC2 & RDS
- ✅ Script untuk deploy dan testing

---

## 🎯 Next Steps

1. Buat repository di GitHub
2. Push code dengan command di atas
3. Verifikasi di GitHub
4. Share link repository ke dosen untuk penilaian
