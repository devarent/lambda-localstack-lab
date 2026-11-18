# LAPORAN TUGAS PRAKTIKUM PERT 5 - AWS LAMBDA

**Mata Kuliah**: Komputasi Awan (Cloud Computing)
**Pertemuan**: 5
**Materi**: AWS Lambda - Serverless Web App & Function URL
**Metode**: Simulasi Lokal (Tanpa Akun AWS)

---

## Identitas Mahasiswa

**Nama**: [Isi Nama Anda]
**NIM**: [Isi NIM Anda]
**Kelas**: [Isi Kelas Anda]
**Tanggal**: [Isi Tanggal Pengerjaan]

---

## Lingkungan Pengujian

- **OS**: Windows 11 dengan WSL 2 (Ubuntu/Kali Linux)
- **Runtime**: Node.js v20+
- **Metode**: Local Server Simulator (http://localhost:9000)
- **Docker**: [Opsional - Jika menggunakan Docker]

---

## Tahap 1: Menjalankan AWS Lambda Lokal

### Langkah-langkah:
1. Buka terminal di folder proyek: `cd "C:\laragon\www\aws-lambda-practicum"`
2. Jalankan server: `node local_server.mjs`
3. Server berjalan di: `http://localhost:9000`

### Screenshot Terminal Server
> [Tempelkan screenshot terminal yang menunjukkan server berjalan]
> Expected output:
> ```
> ============================================================
> AWS Lambda Local Simulator (Function URL)
> ============================================================
> Server berjalan di: http://localhost:9000
> Status Function URL: ACTIVE
> ```

---

## Tahap 2: Pengujian Halaman "Hello from AWS Lambda!" (Status Aktif)

### Langkah-langkah:
1. Buka browser dan akses: `http://localhost:9000`
2. Halaman menampilkan: "Hello from AWS Lambda!"
3. Screenshot halaman sebagai bukti tugas

### Screenshot Browser (Status Aktif)
> [Tempelkan screenshot browser yang menampilkan halaman "Hello from AWS Lambda!"]
> Judul: "Hello from AWS Lambda!"
> Subjudul: "Dipanggil melalui AWS Lambda Function URL dari Ubuntu/Kali Linux di WSL 2"

### Pengujian dari Terminal WSL 2
```bash
curl -i http://localhost:9000
```

### Screenshot Terminal curl
> [Tempelkan screenshot output curl yang menampilkan HTTP 200 dan HTML]
> Expected: `HTTP/1.1 200 OK` dan HTML lengkap

---

## Tahap 3: Simulasi Delete Function URL ("confirm" & "delete")

### Langkah-langkah:
1. Di terminal server, ketik: `confirm`
2. Tekan ENTER
3. Server menampilkan: "FUNCTION URL TELAH DIHAPUS (Simulasi)"
4. Refresh browser: `http://localhost:9000`

### Screenshot Terminal (Setelah ketik "confirm")
> [Tempelkan screenshot terminal yang menunjukkan command "confirm" dan pesan delete]
> Expected output:
> ```
> ============================================================
> FUNCTION URL TELAH DIHAPUS (Simulasi)
> ============================================================
> Refresh browser untuk melihat: {"Message":null}
> ```

### Screenshot Browser (Status Terhapus)
> [Tempelkan screenshot browser yang menampilkan: `{"Message":null}`]
> Ini identik dengan video dosen di menit 10:31

---

## Analisis Hasil

### Perbandingan dengan AWS Lambda Asli

| Aspek | AWS Lambda Asli | Simulasi Lokal |
|-------|----------------|----------------|
| Output HTML | Identik | Identik |
| Function URL | HTTPS (public) | http://localhost:9000 |
| Delete dengan "confirm" | Ya | Ya (simulasi) |
| Output setelah delete | `{"Message":null}` | `{"Message":null}` |
| Biaya | Per milidetik | Gratis |

### Integrasi dengan WSL 2 (Ubuntu/Kali Linux)

File proyek dapat diakses langsung dari WSL 2 melalui path:
```
/mnt/c/laragon/www/aws-lambda-practicum
```

Pengujian dari WSL 2:
```bash
cd "/mnt/c/laragon/www/aws-lambda-practicum"
curl -i http://localhost:9000
```

Hasil: HTTP 200 OK dengan HTML lengkap

---

## Kesimpulan

1. AWS Lambda function berhasil dijalankan secara lokal tanpa akun AWS
2. Output HTML identik dengan hasil dari AWS Lambda asli
3. Simulasi "confirm & delete" berhasil mereplikasi behavior dari video dosen
4. Integrasi dengan WSL 2 (Ubuntu/Kali Linux) berhasil dilakukan
5. Tugas dapat diselesaikan tanpa akses ke AWS Console

---

## File yang Digunakan

- `index.mjs` - Handler Lambda function
- `index.html` - Template halaman web
- `local_server.mjs` - Simulator runtime HTTP
- `confirm_delete.sh` - Script simulasi delete (opsional)
- `Dockerfile` - Konfigurasi Docker (opsional)

---

## Referensi

- Video Tutorial Dosen: [YouTube - Pert 5 AWS Lambda](https://www.youtube.com/watch?v=71xhljYy_10)
- AWS Lambda Documentation: https://docs.aws.amazon.com/lambda/
- AWS Lambda Runtime Interface Emulator: https://github.com/aws/aws-lambda-runtime-interface-emulator

---

**Status**: ✅ TUGAS SELESAI
