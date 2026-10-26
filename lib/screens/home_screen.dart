import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            _buildApaYangKamiLakukanSection(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET APPBAR (PENGGANTI NAVBAR WEB) ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'SPPGIndonesia',
        style: TextStyle(
          color: Color(0xFF1A237E), // Sesuai var(--primary-color)
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black87),
          onPressed: () {
            // Memunculkan pesan pop-up
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menuju halaman Keranjang...')),
            );
          },
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menuju halaman Login...')),
            );
          },
          child: const Text(
            'Masuk',
            style: TextStyle(color: Color(0xFF2979FF), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- WIDGET HERO SECTION ---
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF000051)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Satu Platform untuk Dapur MBG & Supplier',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Kelola pengadaan bahan, stok, produksi, dan laporan dapur MBG—semua dalam satu sistem ERP yang simpel dan terjangkau.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Cepat. Rapi. Transparan.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          
          // Tombol CTA
          // Tombol CTA
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mulai Sekarang diklik! Nanti ke halaman Daftar.')),
                  );
                },
                icon: const Icon(Icons.rocket_launch, color: Color(0xFF1A237E)),
                label: const Text('Mulai Sekarang', style: TextStyle(color: Color(0xFF1A237E))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menampilkan panduan demo...')),
                  );
                },
                icon: const Icon(Icons.arrow_downward, color: Colors.white),
                label: const Text('Coba Demo', style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // Placeholder untuk Ilustrasi Gambar
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Gambar Ilustrasi\n(img/ilustrasi-masak.png)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET APA YANG KAMI LAKUKAN ---
  Widget _buildApaYangKamiLakukanSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text(
            'Apa yang Kami Lakukan?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Menghubungkan ekosistem Dapur MBG secara digital & efisien.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Kartu Ekosistem
          _buildInfoCard(Icons.store, 'Supplier Terverifikasi', 'Menyediakan bahan baku berkualitas dengan harga kompetitif untuk dapur.'),
          const Icon(Icons.arrow_downward, color: Colors.grey, size: 30),
          _buildInfoCard(Icons.phone_android, 'Platform Digital', 'Sistem otomatis yang menjodohkan pesanan, pembayaran, dan logistik.', isPrimary: true),
          const Icon(Icons.arrow_downward, color: Colors.grey, size: 30),
          _buildInfoCard(Icons.restaurant, 'Dapur MBG', 'Fokus memasak makanan bergizi tanpa pusing administrasi.'),
        ],
      ),
    );
  }

  // Helper untuk membuat Card agar kode lebih ringkas
  Widget _buildInfoCard(IconData icon, String title, String desc, {bool isPrimary = false}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: isPrimary ? const Color(0xFF1A237E) : Colors.grey.shade200,
              child: Icon(icon, size: 30, color: isPrimary ? Colors.white : const Color(0xFF1A237E)),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: isPrimary ? const Color(0xFF1A237E) : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}