# 📱 SPPGIndonesia Mobile (2 Role: Dapur MBG & Supplier)

> Aplikasi mobile **Flutter** untuk sistem supply chain berbasis ERP **SPPGIndonesia**, yang menghubungkan dapur Makan Bergizi Gratis (MBG) dengan para supplier.
> Repository ini khusus untuk Tugas Besar **CCK3AAB3 – Pemrograman Perangkat Bergerak** (S1 Rekayasa Perangkat Lunak, Telkom University Purwokerto), terintegrasi dengan Proyek Tingkat 3 dan Perancangan & Pemrograman Web.

**Versi:** 1.0.0 · **Status:** In Development · **Kelompok:** Kokwet

---

## 👥 Anggota Tim

| NIM | Nama | Peran di Proyek |
| :--- | :--- | :--- |
| 103122400004 | Abidah Fatimatuzzahrah | Front-end & UI/UX |
| 103122400005 | Nadia Tambunan | Back-end & System Analyst |
| 103122400019 | Fatikhah Sukma Arti | UI/UX & Front-end |
| 103122400028 | Najwa Areefa Ghaisani (Ketua) | System Analyst & Dokumentasi |

> Pembagian tugas khusus pengerjaan mobile dapat ditambahkan di bagian "Pembagian Tugas Mobile" di bawah.

---

## 📋 1. Deskripsi Aplikasi

SPPGIndonesia hadir untuk mengatasi masalah koordinasi distribusi bahan pangan program MBG yang masih manual: pencatatan PO dan nota memakai spreadsheet sehingga rawan selisih hitungan, pengiriman tanpa surat jalan dan surat penerimaan yang valid sehingga kuantitas barang tidak terkontrol (contoh: pesan 50 kg beras, yang sampai 40 kg), serta tagihan supplier yang sering terlewat.

Versi web desktop mencakup modul ERP yang luas (akuntansi, HRM, aset, CRM, dll). Aplikasi mobile ini **sengaja difokuskan pada 2 role lapangan** yang paling membutuhkan akses cepat dari smartphone:

1. **Dapur MBG (Mitra Dapur)**: memesan bahan baku (Purchase Order), memantau pengiriman, dan mengonfirmasi penerimaan barang.
2. **Supplier**: menerima order, memperbarui status pengiriman, dan mengunggah bukti serah terima.

Kedua role membentuk satu alur transaksi utuh: **PO → pemenuhan order → pengiriman → konfirmasi penerimaan**.

---

## 🎯 2. Tujuan Produk

1. **Mempercepat pengadaan bahan**: petugas dapur membuat PO dari HP dalam hitungan menit.
2. **Transparansi & akuntabilitas**: setiap pengiriman punya bukti digital (foto serah terima) dan kuantitas yang terkunci sejak surat jalan.
3. **Mencegah selisih kuantitas**: kuantitas yang dikirim dibandingkan dengan yang diterima saat konfirmasi penerimaan.
4. **Mencegah keterlambatan masak**: status pengiriman terpantau sehingga jadwal persiapan dapur terjaga.

---

## 👤 3. Karakteristik Pengguna

### Role 1: Dapur MBG (Mitra Dapur)
- Mencari bahan pangan dari supplier terverifikasi dan membuat PO.
- Memantau status pesanan dan stok bahan.
- Mengonfirmasi penerimaan barang saat kurir tiba (jumlah diterima dan jumlah penerima manfaat hadir).

### Role 2: Supplier
- Menerima order masuk dari dapur.
- Melihat rincian barang yang harus disiapkan.
- Mengubah status: *Diproses* → *Dikemas* → *Dikirim*.
- Mengunggah bukti serah terima (foto) saat barang sampai.

> **Catatan istilah:** dokumen SRS/SDD memakai istilah Dapur, Koperasi, Vendor, dan Supplier. Untuk mobile, tim menetapkan istilah **"Dapur MBG"** dan **"Supplier"** secara konsisten di seluruh aplikasi, README, dan presentasi.

---

## 🛠️ 4. Teknologi yang Digunakan

### Mobile (repository ini)

| Komponen | Teknologi | Keterangan |
| :--- | :--- | :--- |
| **Framework** | Flutter (Dart) | Wajib sesuai ketentuan tugas besar |
| **Platform target** | Android | Disiapkan untuk submit Google Play Console |
| **BaaS / Database Client** | `supabase_flutter` | SDK resmi Supabase untuk Auth, Database (PostgreSQL), dan Storage |
| **HTTP client** | `dio` | HTTP client pelengkap untuk integrasi third-party API |
| **State management** | `flutter_riverpod` *(atau Provider/Bloc, pilih satu)* | Pengelolaan state per fitur |
| **Navigasi** | `go_router` | Routing + guard berbasis role |
| **Penyimpanan token** | `flutter_secure_storage` | Token autentikasi tidak disimpan di storage biasa |
| **Konfigurasi** | `flutter_dotenv` | URL Supabase & API key dibaca dari `.env` |
| **Kamera & gambar** | `image_picker` | Foto bukti serah terima diunggah ke Supabase Storage |
| **Tipografi** | `google_fonts` (Raleway) | Konsisten dengan tema web SPPG |
| **Ikon** | Material Icons / `font_awesome_flutter` | |
| **Splash screen** | `flutter_native_splash` | |
| **Pengujian** | `flutter_test`, `integration_test`, `mocktail` | Unit, widget, dan alur end-to-end |
| **Version control** | Git + GitHub | Repo khusus mobile, terpisah dari repo web |
| **AI assistant** | Vibe coding / AI coding assistant *(jika dipakai)* | Wajib ditinjau dan dipahami tim (lihat bagian 11) |

> Daftar package di atas sudah diselaraskan dengan `pubspec.yaml`.

### Backend & Database (Supabase)

| Komponen | Detail |
| :--- | :--- |
| **Platform BaaS** | Supabase Cloud |
| **Database** | PostgreSQL 15+ (Relational Database) |
| **API & Query** | Supabase PostgREST API (otomatis dibuat dari tabel) & Realtime WebSocket |
| **Autentikasi** | Supabase Auth (Email & Password, JWT Token) dengan Role-Based Access Control (RBAC) |
| **Storage** | Supabase Storage (Bucket: `proof_of_delivery` untuk foto bukti timbangan) |
| **Keamanan** | Row-Level Security (RLS) di setiap tabel PostgreSQL |
| **Layanan pihak ketiga** | Midtrans (opsi pembayaran), SMTP (notifikasi email) |

---

## 🏗️ 5. Arsitektur Aplikasi

Aplikasi memakai pendekatan **feature-first** dengan pemisahan layer, mengikuti arsitektur bersih terintegrasi Supabase:

```
Presentation (Page, Widget, State)
        ↓
Domain (Entity, Repository contract, Use case)
        ↓
Data (Supabase Datasource, Repository impl, Model fromJson/toJson)
        ↓
Supabase Flutter SDK (PostgREST, Auth, Storage) → Supabase Cloud (PostgreSQL)
```

### Struktur Folder & Arsitektur yang Diterapkan

```
sppgiindonesia-mobile/
├── lib/
│   ├── main.dart                      # Inisialisasi dotenv, Supabase & root launcher
│   ├── app/
│   │   ├── app.dart                   # SppgApp (MaterialApp.router + tema)
│   │   └── router/                    # GoRouter konfigurasi role Dapur & Supplier
│   ├── core/
│   │   ├── constants/                 # AppConstants, SupabaseTables, ApiEndpoints
│   │   ├── errors/                    # Failures & Exceptions
│   │   ├── network/                   # SupabaseService (Auth, DB, Storage) & ApiClient (Dio)
│   │   ├── storage/                   # SecureStorageService (flutter_secure_storage)
│   │   ├── theme/                     # AppTheme, AppColors, AppTextStyles (Raleway)
│   │   ├── utils/                     # Formatters (Rupiah, Kuantitas)
│   │   └── widgets/                   # CustomButton, CustomCard, LoadingIndicator
│   │   ├── utils/                     # Formatters (Rupiah, Kuantitas)
│   │   └── widgets/                   # CustomButton, CustomCard, LoadingIndicator
│   └── features/
│       ├── auth/                      # Login & Register dengan Role Selector
│       │   ├── domain/entities/
│       │   └── presentation/screens/
│       ├── dashboard/                 # Landing Page & Quick Role Demo
│       │   └── presentation/screens/
│       ├── kitchen/                   # Role Dapur MBG
│       │   ├── catalog/               # Katalog Bahan Baku Segar & Filter Kategori
│       │   ├── purchase_order/        # Form Buat PO, Estimasi Biaya & Jadwal Tiba
│       │   ├── receipt_confirmation/  # Verifikasi Surat Jalan vs Timbangan Fisik
│       │   └── presentation/screens/  # KitchenDashboardScreen (Navigasi Dapur)
│       └── supplier/                  # Role Supplier
│           ├── incoming_orders/       # Checklist Pemenuhan Order PO Dapur
│           ├── shipment/              # State Machine Pengiriman & Surat Jalan Digital
│           ├── proof_of_delivery/     # Upload Foto Bukti Timbangan & Serah Terima
│           └── presentation/screens/  # SupplierDashboardScreen (Navigasi Supplier)
├── assets/
│   ├── images/                        # Aset gambar & ilustrasi (.gitkeep)
│   ├── icons/                         # Aset ikon (.gitkeep)
│   └── fonts/                         # Aset font lokal (.gitkeep)
├── docs/                              # Dokumentasi teknis & screenshots (.gitkeep)
├── integration_test/                  # Integration test end-to-end (app_test.dart)
├── test/                              # Unit & Widget test (widget_test.dart)
├── android/
├── .env.example                       # Template konfigurasi environment
├── pubspec.yaml
└── README.md
```

Struktur di atas mengadopsi pola **feature-first clean architecture** yang memisahkan antara layer *Presentation*, *Domain*, *Data*, dan *Core*. Masing-masing fitur dapat dikembangkan secara modular dan independen antar anggota tim.

---

## 📱 6. Fitur Utama

### Fitur Umum
1. **Splash screen** dengan logo dan branding "SPPGIndonesia".
2. **Registrasi & login** dengan pemilihan tipe akun (Dapur MBG atau Supplier), validasi input, dan opsi *Remember Me*.
3. **Routing berbasis role**: setelah login, sistem mendeteksi tipe akun dan mengarahkan ke dashboard role yang sesuai. Akun hanya dapat membuka fitur sesuai perannya (RBAC).
4. **Bottom navigation bar** yang nyaman dipakai satu tangan.
5. **Dashboard ringkasan** per role.

### 🍳 Role 1: Dapur MBG
1. **Beranda & ringkasan**: status pesanan aktif dan stok bahan.
2. **Katalog bahan baku**: daftar produk dari supplier (nama, satuan, harga, stok), dengan filter kategori dan pencarian.
3. **Purchase Order**: pilih supplier, pilih item dan kuantitas, tanggal/jam kirim, dan metode pembayaran (penuh atau parsial).
4. **Riwayat & status pesanan**: pantau status dari menunggu hingga selesai.
5. **Konfirmasi Penerimaan**: input jumlah barang yang diterima dan jumlah penerima manfaat (siswa) yang hadir, dibandingkan dengan kuantitas pada surat jalan.

### 🚚 Role 2: Supplier
1. **Daftar pesanan masuk** dari dapur, diurutkan berdasarkan jadwal pengantaran.
2. **Detail rincian barang** (checklist item dan kuantitas).
3. **Pembaruan status pengiriman**: Diproses → Dikemas → Dikirim.
4. **Surat jalan digital**: kuantitas terkunci sejak berangkat.
5. **Bukti serah terima (proof of delivery)**: nama penerima dan foto dari kamera.

### Alur Status Pesanan (acuan: State Machine pada SDD)
`DRAFT → PENDING → PROCESSING → READY FOR DELIVERY → ON DELIVERY → COMPLETED` (jalur alternatif: `CANCELLED`).

---

## 🔐 7. Keamanan & Akses Data

- **Autentikasi**: Menggunakan **Supabase Auth** (JWT token terenkripsi), disimpan di `flutter_secure_storage`.
- **Row-Level Security (RLS)**: Setiap tabel di database PostgreSQL Supabase diproteksi kebijakan RLS (Role-Based Access Control):
  - Akun **Dapur MBG** hanya dapat membaca & membuat Purchase Order miliknya serta mengonfirmasi penerimaan barang.
  - Akun **Supplier** hanya dapat melihat pesanan yang masuk ke perusahaannya dan memperbarui status pengiriman/surat jalan.
- **Penyimpanan Credential**: URL Supabase (`SUPABASE_URL`) dan Anon Key (`SUPABASE_ANON_KEY`) dikonfigurasi melalui `.env` (terdaftar di `.gitignore`). Service role key **tidak boleh** dimasukkan ke aplikasi mobile.

---

## 🎨 8. Design System

Diterjemahkan ke `ThemeData` Flutter (`lib/core/theme/`):

| Peran | Warna |
| :--- | :--- |
| Primary Navy | `#1A237E` |
| Gradient | `#1A237E → #0D47A1 → #000051` (135°) |
| Accent Amber | `#FFA000` (status pending, aksi sekunder) |
| Success Green | `#2E7D32` (terkirim, konfirmasi) |
| Background | `#F8F9FA` |
| Surface Card | `#FFFFFF` (elevasi lembut) |

Tipografi: **Raleway**. Seluruh layar mengikuti tema yang sama agar tampilan konsisten.

---

## 🗄️ 9. Integrasi Supabase & Skema Basis Data (Database Schema)

Aplikasi mobile terhubung langsung dengan Supabase BaaS melalui SDK `supabase_flutter`. Kredensial dibaca dari file lingkungan `.env`.

### Skema Tabel PostgreSQL di Supabase

| Nama Tabel | Kolom Utama | Deskripsi |
| :--- | :--- | :--- |
| `profiles` | `id (UUID FK auth.users)`, `full_name`, `role ('kitchen'/'supplier')`, `phone`, `created_at` | Profil pengguna & identifikasi role lapangan |
| `categories` | `id`, `name`, `icon` | Kategori bahan pangan (Beras, Daging, Sayur, dll.) |
| `products` | `id`, `name`, `category_id`, `price`, `unit (Kg/Karung)`, `stock`, `supplier_id` | Katalog bahan baku yang ditawarkan supplier |
| `purchase_orders` | `id`, `kitchen_id`, `supplier_id`, `delivery_date`, `delivery_time`, `status`, `payment_method`, `total_amount` | Purchase Order resmi yang dibuat oleh Dapur MBG |
| `purchase_order_items`| `id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit`, `price_per_unit` | Rincian komoditas dan kuantitas pesanan |
| `shipments` | `id`, `order_id`, `driver_name`, `vehicle_number`, `status`, `departed_at`, `locked_quantities (JSONB)` | Surat jalan pengiriman & kuantitas terkunci armada |
| `receipt_confirmations`| `id`, `order_id`, `beneficiary_count`, `received_quantities (JSONB)`, `receiver_name`, `proof_photo_url` | Konfirmasi timbangan fisik & data porsi siswa penerima |

### Supabase Storage Bucket
- **`proof_of_delivery`**: Bucket untuk menampung berkas foto bukti fisik timbangan dan serah terima bahan dari kamera kurir/petugas.

---

## 🚀 10. Cara Menjalankan Aplikasi

**Prasyarat**
- Flutter SDK (stable), Dart SDK
- Android Studio / VS Code dengan plugin Flutter
- Emulator Android atau perangkat fisik
- Proyek Supabase aktif (URL & Anon Key)

**Langkah**

```bash
# 1. Clone repository
git clone <URL-REPOSITORY>
cd sppgiindonesia-mobile

# 2. Install dependency
flutter pub get

# 3. Siapkan konfigurasi lingkungan
cp .env.example .env
# Isi SUPABASE_URL dan SUPABASE_ANON_KEY di file .env

# 4. Cek lingkungan
flutter doctor

# 5. Jalankan aplikasi
flutter run

# (opsional) Jalankan pengujian
flutter test

# (opsional) Build APK / App Bundle
flutter build apk --release
flutter build appbundle --release
```

**Akun uji** (tanpa kata sandi asli di repo; minta ke tim): akun Dapur MBG dan akun Supplier.

---

## 🖼️ 11. Dokumentasi Tampilan Aplikasi

Letakkan screenshot di `docs/screenshots/` lalu tampilkan di sini.

| Splash | Login/Register | Dashboard Dapur | Katalog |
| :---: | :---: | :---: | :---: |
| _(tambah)_ | _(tambah)_ | _(tambah)_ | _(tambah)_ |

| Buat PO | Konfirmasi Penerimaan | Pesanan Masuk Supplier | Bukti Serah Terima |
| :---: | :---: | :---: | :---: |
| _(tambah)_ | _(tambah)_ | _(tambah)_ | _(tambah)_ |

---

## 🤖 12. Penggunaan Vibe Coding / AI

Pendekatan vibe coding atau AI coding assistant dipakai sebagai alat bantu pengembangan. Tim tetap bertanggung jawab atas:
- **Arsitektur**: pembagian layer/modul dan alur data dapat dijelaskan.
- **Logika bisnis**: validasi dan alur fitur utama benar dan teruji.
- **Keamanan**: pengelolaan credential, token, dan validasi input.
- **UI/UX**: tampilan konsisten dan navigasi mudah dipahami.
- **Pemahaman kode**: kode hasil AI ditinjau, diuji, dan dapat dijelaskan setiap anggota saat presentasi.

---

## ✅ 13. Luaran Wajib Tugas Besar

- [ ] Aplikasi mobile Flutter yang dapat dijalankan dan mendemonstrasikan fitur utama
- [ ] Repository GitHub khusus mobile (source code, dokumentasi, riwayat commit; akses dosen sudah diberikan jika private)
- [ ] PowerPoint presentasi (6 bagian: Pendahuluan & Tim; Analisis Latar Belakang & Bisnis; Arsitektur & Spesifikasi Teknikal; Fitur Utama & Tampilan; Implementasi & Detail Pengembangan; Penutup)
- [ ] Unggahan portofolio LinkedIn (proyek + kontribusi tim/anggota)
- [ ] Screenshot bukti proses submit Google Play Console (tidak wajib publish)
- [ ] Peer review melalui sistem (jadwal disampaikan dosen)

### Acuan Rubrik Penilaian
| Komponen | Yang dipenuhi aplikasi ini |
| :--- | :--- |
| UI Design | Tema konsisten, layout dan skema warna sesuai design system |
| Implementasi Navigasi | `go_router`, bottom navigation, alur sesuai role |
| Model Data | Model Dart (`fromJson/toJson`) terintegrasi dengan API |
| Kinerja Aplikasi | Tanpa crash, respons wajar, efisien di berbagai perangkat |

---

## 📌 14. Keterbatasan & Rencana Pengembangan

- Fitur ERP lain (akuntansi, HRM, aset, CRM) tetap di versi web.
- Integrasi pembayaran Midtrans dan notifikasi push dapat menjadi pengembangan lanjutan.
- Dukungan iOS dan mode offline dapat dipertimbangkan setelah MVP.

---

## 📚 Referensi

- Software Requirements Specification (SRS) SPPGIndonesia v1.0
- Software Design Document (SDD) SPPGIndonesia v1.0
- Dokumentasi MVP SPPG Indonesia
- Dokumen Inisialisasi Proyek dan Timeline Proyek
- Panduan Tugas Besar CCK3AAB3 – Pemrograman Perangkat Bergerak