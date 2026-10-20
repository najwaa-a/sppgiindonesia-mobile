# 📱 PRD — SPPGIndonesia Mobile Experience (2 Role: Dapur MBG & Supplier)

> **Product Requirements Document (PRD)**  
> **Aplikasi:** POSMBG / SPPGIndonesia Mobile Portal  
> **Versi:** 2.0.0  
> **Status:** Approved & In Development  
> **Fokus Utama:** 2 Role Kunci Lapangan (Dapur MBG & Mitra Supplier Pangan)

---

## 📋 1. Latar Belakang & Rasionalisasi

Sistem **SPPGIndonesia** (berbasis POSMBG) memiliki fungsionalitas ERP yang sangat luas di versi web desktop (akuntansi, penggajian, manajemen aset, pajak, dll). Namun, operasional lapangan program **Makan Bergizi Gratis (MBG)** menuntut kecepatan, fleksibilitas, dan kemudahan akses langsung dari smartphone.

Mengonversi seluruh menu ERP desktop ke layar HP akan menurunkan efektivitas kerja pengguna. Oleh karena itu, diputuskan strategi **spesifik 2 Role Lapangan**, yaitu:
1. **Pengelola Dapur MBG (Koki / Tim Dapur)**: Fokus pada perencanaan porsi makan harian, pemesanan bahan baku segar, dan penerimaan kiriman.
2. **Mitra Supplier Pangan (Petani / Koperasi / Kurir)**: Fokus pada penerimaan Purchase Order (PO), pembaruan status kiriman, dan dokumentasi bukti serah terima bahan di dapur.

---

## 🎯 2. Tujuan Produk

1. **Mempercepat Pengadaan Bahan**: Petugas dapur dapat memesan bahan segar untuk esok hari dalam hitungan menit via HP.
2. **Transparansi & Akuntabilitas**: Setiap pengiriman memiliki bukti digital (foto timbangan & serah terima barang di dapur).
3. **Pengalaman Mobile-First**: Antarmuka responsif dengan *touch-friendly button*, *splash screen*, dan *bottom navigation bar* yang nyaman digunakan satu tangan.
4. **Pencegahan Keterlambatan Masak**: Status waktu kirim terpantau secara real-time demi kepastian jam makan anak sekolah.

---

## 👥 3. Karakteristik & Kebutuhan Pengguna (User Persona)

### A. Role 1: Pengelola Dapur MBG (*Buyer / Kitchen Staff*)
* **Kebutuhan**: 
  * Cek kuota porsi makan yang harus disiapkan.
  * Cari bahan pangan segar (beras, ayam, telur, sayur mayur) dari supplier terverifikasi.
  * Buat PO cepat tanpa harus duduk di depan komputer kasir.
  * Konfirmasi kedatangan barang saat kurir tiba di dapur subuh/pagi hari.

### B. Role 2: Mitra Supplier Pangan (*Vendor / Logistics*)
* **Kebutuhan**:
  * Notifikasi instan saat ada order bahan masuk dari dapur.
  * Cek daftar item yang harus ditimbang dan dikemas malam hari.
  * Tombol cepat untuk mengubah status: *Sedang Dikemas* ➔ *Sedang Dikirim*.
  * Ambil foto serah terima fisik langsung dari kamera HP sebagai bukti resmi.

---

## 🛠️ 4. Tech Stack

| Lapisan | Komponen | Versi/Detail | Keterangan |
| :--- | :--- | :--- | :--- |
| **Backend** | PHP & Laravel | PHP ^7.1.3 / Laravel 5.8.* | Core logic & database Eloquent |
| **Arsitektur** | Modular | nwidart/laravel-modules | Terintegrasi dengan modul POS & API |
| **Frontend Mobile** | HTML5, CSS3, Blade | Mobile-first CSS + Bootstrap 4.6 | Ringan, responsif, zero heavy dependencies |
| **Tipografi & Ikon** | Raleway & FontAwesome 5 | Google Fonts & FA 5.15.4 | Konsisten 100% dengan tema web SPPG |
| **Interaktivitas** | Vanilla JavaScript | ES6+ | Splash screen, tab switcher, mock checkout |
| **Database** | MySQL | MySQL 5.7+ / MariaDB | Relasi tabel produk, transaksi, dan user |

---

## 📁 5. Struktur Folder Proyek

Struktur berikut adalah **rekomendasi target** untuk mengembangkan aplikasi Flutter ini secara feature-first. Ini bukan struktur yang seluruhnya sudah tersedia di project; tambahkan folder secara bertahap saat fiturnya mulai dibuat.

```
posmbg_mobile/
├── lib/
│   ├── main.dart                      # Entry point
│   ├── app/
│   │   ├── app.dart                   # Konfigurasi MaterialApp dan tema
│   │   └── router/                    # Deklarasi navigasi dan route
│   ├── core/                          # Kode umum yang dipakai lintas fitur
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── network/                   # HTTP client dan konfigurasi API
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/                   # Widget umum yang reusable
│   └── features/
│       ├── auth/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── catalog/
│       ├── orders/
│       ├── kitchen/
│       └── supplier/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── test/
│   ├── core/
│   └── features/                      # Tes mengikuti struktur lib/
├── integration_test/                  # Tes alur aplikasi end-to-end
├── docs/                              # Dokumentasi teknis dan API
├── android/                           # Konfigurasi platform Android
├── web/                               # Berkas platform Flutter Web
├── pubspec.yaml
└── README.md
```

`auth/` menunjukkan pola pemisahan yang dapat diterapkan juga pada fitur lain: `data/` untuk model, datasource, dan implementasi repository; `domain/` untuk entity, kontrak repository, dan use case; serta `presentation/` untuk page, widget, dan pengelolaan state. Untuk fitur kecil, mulai dengan struktur yang lebih sederhana lalu pisahkan lapisannya saat kompleksitas bertambah. Hindari membuat folder kosong hanya untuk mengikuti contoh.

---

## 🎨 6. Design System & Identitas Visual

* **Primary Navy**: `#1a237e` (Navbar atas, tombol utama, identitas resmi)
* **Secondary Gradient**: `linear-gradient(135deg, #1a237e 0%, #0d47a1 50%, #000051 100%)`
* **Accent Gold / Amber**: `#ffa000` (Status pending, badge rating, tombol aksi sekunder)
* **Success Green**: `#2e7d32` (Status terkirim, tombol konfirmasi serah terima)
* **Background Canvas**: `#f8f9fa` (Kenyamanan mata saat operasional outdoor/dapur)
* **Surface Card**: `#ffffff` (Elevasi lembut `box-shadow: 0 4px 15px rgba(0,0,0,0.05)`)

---

## 📱 7. Detail Fitur Per Role

### 🌟 Fitur Umum (Global Components)
1. **Splash Screen Animasi**:
   * Menampilkan logo ikon piring & sendok garpu dengan animasi *pulse/bounce*.
   * Branding "SPPGIndonesia - Platform ERP Dapur MBG".
   * Progress bar loading halus, otomatis hilang dalam 2 detik (tersimpan di `sessionStorage`).
2. **Role Switcher Demo (Bar Atas)**:
   * Memudahkan pergantian mode simulasi antara **Mode Dapur MBG** dan **Mode Supplier** secara instan.
3. **Bottom Navigation Bar**:
   * Ramah navigasi jempol dengan indikator aktif berwarna emas/navy.

---

### 🍳 Fitur Role 1: Pengelola Dapur MBG
1. **Beranda & Jadwal Masak**:
   * Banner status jadwal makan bergizi besok (contoh: 1.200 porsi paket Nasi Ayam Sayur).
   * Quick filter kategori bahan pangan: Beras, Ayam & Daging, Sayur Segar, Telur, Bumbu Dapur.
2. **Katalog Bahan Baku Segar**:
   * Kartu produk dengan foto, satuan kilogram/karung, harga grosir supplier, dan sisa stok.
   * Tombol *+ Tambah ke Keranjang*.
3. **Keranjang Pengadaan (PO Masak)**:
   * Kalkulasi total kebutuhan belanja dan estimasi biaya per porsi.
   * Pilihan jam kirim wajib tiba (contoh: *Subuh 04.30 WIB*).

---

### 🚚 Fitur Role 2: Mitra Supplier Pangan
1. **Daftar Pesanan Masuk (PO Dapur)**:
   * List pesanan dari dapur binaan yang harus dipenuhi.
   * Prioritas jadwal pengantaran bahan segar.
2. **Detail Rincian Barang Timbang**:
   * Checklist kuantitas barang (misal: Ayam Potong 50 Kg, Wortel 30 Kg, Beras 150 Kg).
3. **Pembaruan Status Cepat**:
   * Tombol satu sentuhan: *[Mulai Kirim Bahan]* saat armada berangkat.
4. **Bukti Serah Terima Digital (Proof of Delivery)**:
   * Input nama penerima di dapur & simulasi upload foto timbangan fisik di lokasi.

---

## 🛣️ 8. Endpoint & Integrasi Route

* **URL Tampilan Mobile**: `/mobile`
* **Route Name**: `mobile.portal`
* **Integrasi API yang Tersedia**:
  * `GET /api/product` / `GET /api/categories`: Ambil daftar bahan pangan.
  * `POST /api/cart/add` & `GET /api/cart`: Kelola keranjang belanja bahan.
  * `POST /api/booking-checkout`: Submit pesanan terikat jadwal pengantaran.

---

## 📊 9. Kriteria Penerimaan (Acceptance Criteria)

- [x] Tampilan 100% responsif dan pas di resolusi smartphone (360px – 430px).
- [x] Terdapat animasi splash screen saat pertama kali dibuka.
- [x] Pengguna dapat berpindah peran (Dapur MBG ↔ Supplier) dengan lancar.
- [x] Semua fungsi utama kedua role (Katalog, Keranjang, Lacak Pengiriman, Status Supplier) dapat disimulasikan secara visual.
- [x] Desain dan warna identik dengan identitas web SPPGIndonesia.
