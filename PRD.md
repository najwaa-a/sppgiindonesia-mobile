# PRD — Aplikasi Flutter SPPGIndonesia

> **Status:** Draft untuk diskusi  
> **Produk:** POSMBG / SPPGIndonesia Mobile  
> **Platform yang direncanakan:** Android (rilis awal)  
> **Ruang lingkup:** Marketplace Supplier dan operasional Dapur/Koperasi MBG  
> **Tanggal analisis:** 20 Oktober 2026

Dokumen ini adalah rancangan produk untuk aplikasi Flutter baru. Dokumen ini tidak mengubah cakupan sistem Laravel yang sedang berjalan dan tidak menyatakan bahwa fitur yang dijelaskan sudah tersedia.

## 1. Ringkasan

SPPGIndonesia saat ini merupakan sistem POS/ERP berbasis Laravel 5.8 dengan antarmuka web, database, modul bisnis, serta sejumlah endpoint API. Aplikasi Flutter direncanakan sebagai **klien mobile terpisah** yang berkomunikasi dengan backend Laravel melalui HTTPS dan JSON. Flutter tidak terhubung langsung ke database.

Catatan kebutuhan mengidentifikasi lima jenis pengguna: **Supplier, Dapur, Koperasi, SuperAdmin, dan Customer** (Customer dapat menjadi Dapur resmi). Pengalaman utama yang diminta mencakup marketplace dan pendaftaran Supplier, pengadaan dan operasi back-office Dapur/Koperasi, serta penjelajahan daftar Supplier oleh calon Customer sebelum mendaftar sebagai Dapur.

Ruang lingkup mobile belum berarti memindahkan seluruh ERP sekaligus. Rekomendasi adalah mengirim produk secara bertahap: fondasi akun/role dan marketplace Supplier, alur pengadaan serta penjualan Dapur/Koperasi yang paling dibutuhkan, lalu modul back-office lainnya sesuai prioritas dan API. Backend Laravel tetap menjadi sumber data dan aturan bisnis. Endpoint produk, autentikasi, keranjang, transaksi, serta modul web yang ada dapat dievaluasi untuk digunakan kembali, tetapi API khusus mobile dan otorisasi per business/role harus dipastikan.

## 2. Kondisi Sistem Saat Ini

### Yang sudah teridentifikasi

- Backend Laravel 5.8/PHP dengan database MySQL/MariaDB dan sistem permission.
- API Passport untuk login/token, data produk/kategori, keranjang, checkout/transaksi, booking, dan beberapa fungsi lain.
- Alur pembelian dan purchase order tersedia pada route web Laravel yang memerlukan sesi web.
- Halaman `/mobile` berbasis Blade sudah ada sebagai demonstrasi tampilan.
- Repository memiliki modul/area ERP yang berhubungan dengan Accounting, Asset Management, CRM, Essentials/HRM, Manufacturing, dan Product Catalogue; sebagian besar alur operasional utamanya tetap berbasis web.
- Business memiliki klasifikasi `provider_role`, pengguna memiliki permission, serta ada relasi `user_suppliers`; model ini perlu dipetakan terhadap role produk Supplier/Dapur/Koperasi.

### Status modul menurut catatan kebutuhan

Catatan memberi tanda tersedia pada HRM, Inventory/Products, Accounting, Purchase, Sales, Contacts, dan Dashboard. Asset Management serta CRM tercantum tanpa tanda. Ini adalah status berdasarkan catatan pemilik kebutuhan, bukan hasil verifikasi bahwa setiap modul sudah lengkap, siap produksi, atau memiliki API mobile. Keberadaan modul/fitur web tidak otomatis berarti fitur tersebut tersedia di Flutter.

### Yang belum dianggap siap untuk aplikasi produksi

- Belum ada proyek Flutter (`pubspec.yaml` dan source Dart belum ditemukan).
- Halaman `/mobile` menggunakan data statis dan interaksi simulasi untuk keranjang, checkout, konfirmasi, dan bukti foto.
- Dalam `routes/api.php` yang ditinjau, belum tampak rangkaian API mobile yang mencakup marketplace Supplier, pendaftaran/approval Supplier, disbursement, PO lintas business, pembaruan status pengiriman, dan proof of delivery.
- Kontrak respons, otorisasi per peran, unggah bukti, notifikasi, dan perilaku saat koneksi terputus perlu ditetapkan/divalidasi.

Route web purchase order yang sudah ada bukan pengganti API mobile: autentikasi sesi web, middleware, respons HTML, dan kontrol aksesnya harus ditinjau sebelum dapat digunakan oleh klien Flutter.

## 3. Tujuan Produk

- Menyediakan marketplace agar calon pembeli dapat menemukan Supplier dan Supplier dapat mendaftar.
- Memudahkan Dapur/Koperasi mengelola pembelian, stok, penjualan, pembayaran, dan ringkasan usaha dari ponsel.
- Menyediakan alur supplier untuk memenuhi PO dan melihat pembagian hasil penjualan (disbursement) secara transparan.
- Memungkinkan calon Customer melihat informasi Supplier sebelum mendaftar sebagai Dapur resmi.
- Menghubungkan aktivitas operasional dengan data POSMBG tanpa menggandakan aturan bisnis.

### Indikator keberhasilan awal

Target di bawah adalah usulan untuk diuji bersama pemilik proses bisnis, bukan hasil pengukuran saat ini:

- Pengguna yang berwenang dapat menyelesaikan alur utama tanpa bantuan admin.
- Minimal 95% percobaan pembuatan/pembaruan pesanan pada koneksi normal berakhir dengan status sukses atau pesan kegagalan yang dapat ditindaklanjuti.
- Waktu untuk membuat pesanan rutin tidak lebih dari 2 menit setelah pengguna memahami alur.
- Setiap perubahan status pengiriman dan penerimaan tercatat dengan pengguna serta waktu kejadian.

## 4. Pengguna, Role, dan Hak Akses

### Pengelola Dapur MBG

Mengelola inventory/produk, purchase order, sales, supplier dan customer, payment method, accounting/laporan keuangan, dashboard/statistik, asset management, serta HRM. Fitur yang diaktifkan dan akses tiap pengguna harus mengikuti permission business.

### Mitra Supplier Pangan

Membutuhkan marketplace/listing, proses pendaftaran/onboarding, pengelolaan penawaran/produk, pemenuhan PO dan pengiriman, serta informasi disbursement atau transfer hasil penjualan.

### Koperasi

Catatan meminta fungsi operasional yang sama dengan Dapur: inventory, purchase, sales, asset management, HRM, supplier/customer contacts, accounting, payment methods, dan dashboard/statistik. Data Supplier yang dikelola Koperasi perlu langsung tersedia sebagai Supplier yang dapat dipilih. Perlu dipastikan apakah Koperasi adalah tipe business tersendiri, role pengguna, atau business dengan permission tertentu.

### Customer / calon Dapur

Sebelum menjadi Dapur resmi, Customer dapat melihat informasi Supplier di marketplace. Setelah itu Customer dapat mengajukan/melakukan pendaftaran sebagai Dapur sesuai alur verifikasi yang ditetapkan.

### SuperAdmin

SuperAdmin tercantum sebagai role di catatan kebutuhan. Tanggung jawab yang terindikasi adalah mengelola akun, role, pendaftaran/approval, dan relasi business, tetapi hak akses rinci dan apakah SuperAdmin memakai aplikasi mobile atau back-office web masih perlu diputuskan.

### Prinsip otorisasi

- Role dan permission ditentukan oleh backend, bukan switcher role pada aplikasi.
- Data dan tindakan dibatasi menurut business, lokasi, dan hubungan Supplier–Dapur/Koperasi.
- Supplier hanya dapat melihat PO, listing, transaksi, dan disbursement yang menjadi haknya.
- Keputusan sementara: Supplier login melalui business/user terpisah; admin menghubungkan Supplier ke Dapur, lalu Dapur memilih Supplier yang terhubung saat membuat PO. Model relasi aktual tetap perlu dipetakan terhadap `user_suppliers` dan `contact_id`.
- Setiap aksi harus divalidasi ulang oleh backend; menyembunyikan tombol di UI bukan kontrol keamanan.
- Catatan menyebut opsi registrasi **Supplier**, **Dapur**, atau **Keduanya**, sedangkan keputusan diskusi sebelumnya adalah satu akun hanya memiliki satu role. Konflik ini belum diputuskan; implementasi harus mengikuti keputusan final dan model izin backend.
- Catatan juga menyebut alur registrasi pengguna, sementara keputusan sebelumnya menyatakan akun disiapkan admin. Perlu dibedakan antara pengajuan pendaftaran publik, approval admin, dan pembuatan kredensial/akun aktif.

## 5. Cakupan

### Deliverable Sprint 1 menurut catatan

Catatan Sprint 1 meminta timeline, SRS, flow chart (ditandai selesai pada catatan), dan demonstrasi MVP yang menunjukkan fitur sistem yang sudah ada serta dokumentasi fitur per modul, termasuk screenshot dan penjelasan. Ini adalah deliverable dokumentasi/demo Sprint 1, bukan definisi bahwa seluruh fitur pada PRD harus selesai dalam satu sprint. Target “20 Maret” dan “Selasa” tidak mencantumkan tahun/tanggal yang cukup jelas sehingga belum ditetapkan sebagai jadwal rilis.

### Cakupan produk yang diminta

| Area | Supplier | Dapur | Koperasi | Customer | SuperAdmin |
|---|---|---|---|---|---|
| Akun | Daftar/onboarding | Daftar menjadi Dapur resmi | Akun business/anggota perlu dikonfirmasi | Lihat Supplier lalu daftar | Kelola dan/atau setujui akun; detail perlu diputuskan |
| Marketplace | Listing/penawaran produk | Cari dan pilih Supplier | Data Supplier langsung tersedia sebagai Supplier | Jelajahi Supplier sebelum pendaftaran | Moderasi/administrasi perlu dikonfirmasi |
| Purchase/PO | Terima dan penuhi order; alur beli dari supplier sendiri juga tercatat di notes | Pilih supplier, item, tanggal/status, mapping item, harga beli/jual, kuantitas, pembayaran | Sama dengan Dapur | Tidak disebut | Administrasi sesuai permission |
| Sales/Shipment | Pilih item, bandingkan harga dengan PO/dokumen, lanjutkan shipment | Buat penjualan, cek harga dan shipment | Sama dengan Dapur | Tidak disebut | Administrasi sesuai permission |
| Operasi back-office | Disbursement hasil penjualan | Inventory, Accounting, HRM, Asset, Contacts, Dashboard/statistik | Inventory, Accounting, HRM, Asset, Contacts, Dashboard/statistik | Tidak disebut | Laporan/konfigurasi lintas business perlu dikonfirmasi |
| CRM | Belum dirinci | Modul tersedia sebagai kandidat | Modul tersedia sebagai kandidat | Belum dirinci | Belum dirinci |

### Usulan urutan delivery (perlu disepakati)

1. **Fondasi:** Android, login/pendaftaran atau approval, role/business context, marketplace Supplier yang dapat dilihat Customer.
2. **Transaksi inti:** alur purchase/PO dan sales/shipment untuk Dapur/Koperasi serta pemenuhan PO Supplier.
3. **Keuangan:** payment method, pembayaran parsial/penuh, accounting/COA dan approval, serta disbursement.
4. **Operasional lanjutan:** inventory/product mapping, asset management, HRM, contacts, dashboard/statistik, dan CRM.

Urutan ini usulan berdasarkan dependensi bisnis, bukan keputusan scope final. Perlu pemilihan subset MVP yang benar-benar dapat ditunjukkan dalam satu sprint.

## 6. Alur Utama dari Catatan

### 6.1 Customer dan pendaftaran

1. Pengunjung membuka marketplace dan melihat informasi Supplier sebelum terdaftar sebagai Dapur resmi.
2. Pengunjung memilih alur registrasi Supplier, Dapur, atau keduanya sesuai catatan.
3. Sistem memvalidasi informasi pendaftar; mekanisme approval, aktivasi akun, dan kemungkinan satu akun multi-role harus diputuskan.
4. Setelah login, backend menentukan business context dan permission yang aktif.

### 6.2 Supplier/Koperasi membuat pembelian

Catatan menggambarkan alur: pilih Supplier, pilih item, tanggal, status order, mapping item (buat/mapping produk baru bila belum tersedia), isi harga beli dan jual serta kuantitas, lalu pilih metode pembayaran dan jumlah pembayaran (parsial atau lunas). Alur operasional perlu memisahkan pembelian oleh Supplier/Koperasi dari PO Dapur kepada Supplier, karena keduanya dapat memakai jenis transaksi dan pihak berbeda.

### 6.3 Dapur membuat PO ke Supplier/Koperasi

1. Dapur memilih Supplier/Koperasi yang tersedia dan terhubung.
2. Dapur memilih item; bila belum ada padanan, tentukan proses mapping/pembuatan produk.
3. Dapur mengisi tanggal, status, harga, kuantitas, dan pembayaran parsial atau penuh sesuai permission.
4. Backend menyimpan PO dan mengembalikan nomor serta status.
5. Dapur dan Supplier dapat melihat status yang sama sesuai akses masing-masing.

### 6.4 Supplier memenuhi order dan shipment

1. Supplier melihat PO yang memang ditujukan kepadanya.
2. Supplier menerima/menolak atau memproses item, memperbarui status persiapan/pengiriman, dan memilih item untuk sales/shipment sesuai aturan.
3. Harga dibandingkan dengan PO/dokumen hard copy bila proses bisnis mengharuskannya.
4. Supplier menandai keberangkatan/shipment dan mengirim bukti yang diwajibkan.
5. Pihak yang berwenang mengonfirmasi jumlah diterima dan selisih.

**Keputusan terbuka:** catatan sebelumnya belum menentukan siapa yang mengunggah bukti serah-terima dan siapa yang mengesahkan penerimaan. Status PO web saat ini mencakup `ordered`, `partial`, `completed`; status pengiriman yang ada mencakup `ordered`, `packed`, `shipped`, `delivered`, `cancelled`. Status tersebut perlu dipetakan ke proses baru, bukan diasumsikan sudah cocok.

### 6.5 Accounting dan asset management

- Accounting: buat COA, mapping modul dengan COA, dan jalankan approval sesuai hak akses.
- Asset: buat kategori dan aset, lalu alokasikan aset ke business location.
- Setiap perubahan finansial/asset harus tetap dilakukan dan diaudit backend.

## 7. Kebutuhan Fungsional

| ID | Prioritas | Kebutuhan |
|---|---|---|
| F-01 | Must | Login, pendaftaran/approval sesuai kebijakan final, pemulihan sesi, dan pemuatan role/business dari backend. |
| F-02 | Must | Customer dapat menelusuri informasi Supplier yang disetujui untuk publik sebelum mendaftar. |
| F-03 | Must | Supplier dapat mengajukan pendaftaran/listing; status verifikasi dan publikasinya dikelola backend/admin. |
| F-04 | Must | Dapur/Koperasi dapat melihat dan mengelola produk, kategori, brand, dan inventory sesuai permission. |
| F-05 | Must | Dapur/Koperasi dapat membuat dan memantau purchase/PO: supplier, item/mapping, tanggal, status, harga beli/jual, kuantitas, dan pembayaran. |
| F-06 | Must | Supplier dapat melihat PO/order yang dialokasikan kepadanya dan memproses statusnya. |
| F-07 | Must | Dapur/Koperasi dan Supplier dapat menjalankan sales/shipment sesuai peran, termasuk pengecekan harga terhadap PO bila diwajibkan. |
| F-08 | Must | Sistem mendukung metode pembayaran dan pencatatan pembayaran parsial/penuh sesuai aturan backend. |
| F-09 | Should | Supplier dapat melihat rincian penjualan dan status disbursement; eksekusi transfer memerlukan workflow dan integrasi pembayaran yang disepakati. |
| F-10 | Should | Dapur/Koperasi dapat melihat kontak Supplier/Customer, dashboard/statistik, dan laporan accounting sesuai permission. |
| F-11 | Should | Pengguna berwenang dapat mengelola/melihat HRM dan asset management di mobile; prioritas layar dan tindakan perlu ditetapkan. |
| F-12 | Should | Dukungan CRM sesuai proses bisnis yang belum dirinci dalam catatan. |
| F-13 | Must | Validasi seluruh akses per business/role di backend; pengguna tidak dapat mengakses data pihak lain dengan mengganti ID. |
| F-14 | Must | Aplikasi menangani koneksi gagal, timeout, validasi, token tidak berlaku, dan respons server tanpa mengarang status sukses. |
| F-15 | Later | Notifikasi, mode baca offline, dan sinkronisasi transaksi setelah aturan produk disepakati. |

## 8. Kebutuhan Non-Fungsional

- **Platform:** Android untuk rilis awal berdasarkan keputusan diskusi. Dukungan iOS dapat dipertimbangkan sebagai tahap terpisah.
- **Bahasa dan format:** Bahasa Indonesia; tanggal, waktu, dan mata uang mengikuti konfigurasi bisnis/timezone server.
- **Keamanan:** HTTPS; token tidak disimpan dalam plain text; token tidak dicatat ke log; validasi otorisasi selalu di backend.
- **Privasi:** Foto bukti hanya dapat diakses oleh pihak yang berwenang dan mengikuti aturan retensi data.
- **Aksesibilitas:** ukuran sentuh memadai, kontras jelas, label untuk kontrol, dan tampilan yang tetap dapat dipakai pada layar kecil.
- **Keandalan:** perubahan status hanya dianggap berhasil setelah dikonfirmasi backend; cegah pengiriman ganda atau dokumentasikan kebijakan idempotensi.
- **Performa:** daftar menggunakan pagination/filter server bila jumlah data besar; gambar dioptimalkan dan memiliki batas ukuran yang disepakati.
- **Observabilitas:** log aplikasi tidak memuat password, token, atau konten sensitif; kegagalan integrasi dapat ditelusuri dengan request/correlation ID bila backend mendukung.

## 9. Integrasi Backend

### Endpoint yang sudah terlihat di `routes/api.php`

| Kemampuan | Endpoint contoh | Catatan |
|---|---|---|
| Login | `POST /api/login` | Mengembalikan token Passport dan data pengguna. Perlu validasi pemetaan role untuk mobile. |
| Profil/sesi | `GET /api/user`, `POST /api/logout` | Berada di middleware `auth:api`. |
| Produk/kategori | `GET /api/product`, `GET /api/categories` | Endpoint katalog sudah ada; filter, unit, stok, harga dan kebijakan akses perlu diverifikasi. |
| Keranjang | `GET /api/cart`, `POST /api/cart/add` | Endpoint terautentikasi tersedia; bentuk payload dan kecocokannya dengan PO MBG perlu diuji. |
| Checkout/riwayat | Endpoint cart/transaction, purchase history, dan beberapa endpoint booking | Ada untuk alur transaksi/booking yang sudah berjalan; tidak boleh diasumsikan setara dengan pengadaan dan penerimaan bahan. |

### API yang perlu dirancang atau dikonfirmasi

- Profil pengguna yang memberikan role, permission, business type, business/location context, dan status approval.
- Pendaftaran Supplier/Dapur/Keduanya, validasi, approval, onboarding, dan pengelolaan listing marketplace.
- Daftar publik Supplier dengan field yang aman untuk dilihat sebelum login.
- Relasi akun Supplier ke business Dapur/Koperasi dan pemetaan business/contact/produk ke PO.
- Pembuatan dan pembacaan PO/purchase dengan item mapping, harga beli/jual, kuantitas, status, tanggal, serta pembayaran parsial/lunas.
- Pemenuhan order oleh Supplier, status shipment, perbandingan harga terhadap dokumen, dan konfirmasi penerimaan.
- Upload dan akses bukti, dengan batas file, tipe file, retensi, serta izin.
- Payment method, accounting/COA, approval, ledger/report, dan status disbursement; integrasi transfer dan reconciliation belum teridentifikasi.
- Inventory/product creation setelah pembelian, termasuk kategori, brand, dan relasi stok per lokasi.
- Asset categories/items/allocation, HRM, contacts, dashboard/statistik, dan CRM sesuai modul yang dipilih untuk mobile.
- Audit trail, notifikasi bila diperlukan, pagination, format tanggal/mata uang, validasi, error, token kedaluwarsa, serta idempotensi transaksi.

Route purchase order dan shipment confirmation pada `routes/web.php` menunjukkan alur web terkait telah ada, tetapi bukan kontrak REST yang siap dipanggil Flutter. Backend perlu menyediakan API yang aman, terdokumentasi, dan mempertahankan aturan bisnis yang sama.

## 10. Kriteria Penerimaan

- Customer dapat melihat hanya informasi Supplier yang memang ditandai publik; data privat/finansial tidak terbuka.
- Pendaftaran menghasilkan akun atau permohonan dengan status yang jelas; role final diberikan oleh backend sesuai kebijakan approval.
- Dapur/Koperasi dapat menyelesaikan transaksi PO/purchase yang dipilih untuk MVP, dengan item, harga, jumlah, tanggal dan pembayaran yang tersimpan di server.
- Supplier hanya dapat melihat/memperbarui order yang menjadi hak business-nya.
- Pembayaran parsial/penuh tercermin konsisten pada transaksi dan laporan backend.
- Status shipment, bukti, dan penerimaan memiliki audit trail; gagal upload/konfirmasi tidak tampil sebagai sukses.
- Modul ERP yang belum menjadi bagian rilis awal tetap dapat dikelola melalui sistem web dan tidak dianggap selesai hanya karena tercantum di PRD.
- Kesalahan jaringan/API ditampilkan dengan aman dan tidak menghilangkan input yang belum tersimpan.
- Semua angka, stok, status, listing, dan laporan berasal dari backend, bukan data contoh.
- Android build dan alur tiap role yang termasuk rilis lulus pengujian pada perangkat/emulator target.

## 11. Usulan Arsitektur Klien

- Flutter/Dart Android dengan struktur fitur terpisah (auth/onboarding, marketplace, inventory, purchase/PO, sales/shipment, payment/accounting, asset/HRM, dashboard).
- Lapisan UI, state management, repository, dan klien API dipisahkan agar mudah diuji.
- Konfigurasi base URL berbeda per environment dan tidak menyimpan secret di source control.
- Token disimpan memakai penyimpanan aman platform; HTTP client menambahkan header autentikasi sesuai skema backend dan menangani respons 401 secara konsisten.
- Kamera/galeri hanya digunakan untuk bukti yang diperlukan dan setelah aturan privasi serta format unggahan disepakati.
- Laravel tetap menjadi pemilik aturan bisnis dan persistensi; Flutter tidak mengakses MySQL langsung.

Pilihan library Flutter belum ditetapkan. Pilih setelah versi Flutter, pola autentikasi, upload, notifikasi, dan kebutuhan pengujian disepakati.

## 12. Risiko dan Keputusan Terbuka

1. Pendaftaran pada catatan menyediakan Supplier, Dapur, atau Keduanya, sedangkan keputusan diskusi sebelumnya menetapkan satu akun satu role. Apakah opsi Keduanya berarti multi-role sungguhan atau dua jenis akun/business yang terhubung?
2. Apakah akun dibuat langsung oleh pengguna melalui registrasi, dibuat admin, atau pengguna mengajukan lalu admin menyetujui/mengaktifkan?
3. Apakah Koperasi adalah tipe business, role, atau akun organisasi dengan user dan permission sendiri?
4. Apa tugas SuperAdmin di aplikasi mobile, dan apakah role ini sebaiknya hanya memakai back-office web?
5. Apakah Customer adalah status pra-registrasi Dapur, role tersendiri, atau keduanya?
6. Bagaimana mapping Supplier business, contact Supplier, akun login, relasi `user_suppliers`, dan `transactions.contact_id` di data aktual?
7. Dari daftar HRM, Inventory, Accounting, Purchase, Sales, Asset, Contacts, Dashboard, dan CRM, mana yang benar-benar harus masuk MVP Flutter? Prioritas release belum dipastikan.
8. Untuk alur purchase dua arah, pihak mana membeli dari siapa? Apakah Dapur/Koperasi membuat PO ke Supplier, sementara Supplier/Koperasi juga perlu purchase dari supplier hulunya?
9. Siapa mengunggah bukti shipment dan siapa mengonfirmasi penerimaan/selisih?
10. Bagaimana definisi disbursement (penerima, komisi/fee, siklus, minimum payout, refund, reconciliation, metode transfer)?
11. Apakah pemeriksaan harga terhadap PO/dokumen hard copy wajib, dan siapa yang berwenang menyetujui perbedaan?
12. Apa arti tanggal Sprint 1 “20 Maret” dan target “Selasa”—tahun dan tanggal pastinya?
13. Siapa pemilik API dan lingkungan staging untuk validasi kontrak sebelum Flutter dimulai?

## 13. Tahapan Implementasi yang Disarankan

1. **SRS dan alur final:** validasi peran, purchase vs PO, sales/shipment, marketplace, disbursement, timeline, dan flow chart.
2. **API readiness:** dokumentasikan kontrak, tambahkan endpoint yang kurang, uji permission lintas business serta audit.
3. **Fondasi Android:** bootstrap Flutter, autentikasi/onboarding, business context, navigasi, serta error handling.
4. **Marketplace dan transaksi inti:** katalog/listing Supplier, pembelian/PO, item mapping, pembayaran, dan status.
5. **Dapur/Koperasi operations:** inventory, sales/shipment, contacts, dashboard, kemudian accounting/asset/HRM/CRM sesuai prioritas.
6. **Supplier settlement:** laporan hasil penjualan, disbursement, rekonsiliasi dan bukti payout setelah aturan keuangan disepakati.
7. **MVP demo dan rilis bertahap:** tunjukkan fitur yang benar-benar berfungsi, dokumentasikan screenshot dan penjelasan tiap modul, lalu uji pada Android target.
