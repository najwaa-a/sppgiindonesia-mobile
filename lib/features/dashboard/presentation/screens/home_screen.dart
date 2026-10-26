import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';

/// Halaman Home / Landing Page SPPGIndonesia Mobile
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
            _buildQuickRoleDemoSection(context),
            _buildApaYangKamiLakukanSection(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET APPBAR ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'SPPGIndonesia',
        style: TextStyle(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.push('/login'),
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
        gradient: AppColors.heroGradient,
      ),
      child: Column(
        children: [
          const Text(
            'Satu Platform untuk Dapur MBG & Supplier',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Kelola pengadaan bahan, PO, pengiriman, dan serah terima bahan Makan Bergizi Gratis (MBG)—semua dalam genggaman smartphone.',
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.push('/register'),
                icon: const Icon(Icons.rocket_launch, color: AppColors.primaryNavy),
                label: const Text('Mulai Sekarang', style: TextStyle(color: AppColors.primaryNavy)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => context.push('/login'),
                icon: const Icon(Icons.login, color: Colors.white),
                label: const Text('Masuk Portal', style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET ROLE DEMO SHORTCUT ---
  Widget _buildQuickRoleDemoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.surfaceSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Akses Cepat 2 Role Lapangan', style: AppTextStyles.headingSmall),
          const SizedBox(height: 8),
          const Text(
            'Pilih salah satu dashboard role untuk melihat tampilan spesifik fitur lapangan:',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildRoleCard(
                  context: context,
                  title: 'Dapur MBG',
                  subtitle: 'PO & Konfirmasi Penerimaan',
                  icon: Icons.restaurant,
                  color: AppColors.primaryNavy,
                  route: '/kitchen/dashboard',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRoleCard(
                  context: context,
                  title: 'Supplier',
                  subtitle: 'Pesanan & Bukti Kirim',
                  icon: Icons.local_shipping,
                  color: AppColors.accentAmber,
                  route: '/supplier/dashboard',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              radius: 20,
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET APA YANG KAMI LAKUKAN ---
  Widget _buildApaYangKamiLakukanSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fokus 2 Role Lapangan', style: AppTextStyles.headingSmall),
          const SizedBox(height: 8),
          const Text(
            'Solusi digital terintegrasi untuk mencegah selisih kuantitas bahan dan keterlambatan masak.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          _buildFeatureTile(
            icon: Icons.shopping_basket_outlined,
            title: 'Katalog & Purchase Order Dapur',
            description: 'Pesan bahan pangan segar dengan takaran tepat sesuai jadwal porsi harian anak sekolah.',
          ),
          const SizedBox(height: 16),
          _buildFeatureTile(
            icon: Icons.checklist_rtl_rounded,
            title: 'Checklist Pemenuhan Pesanan Supplier',
            description: 'Supplier memproses order, mengemas, dan mengunci kuantitas sejak surat jalan dibuat.',
          ),
          const SizedBox(height: 16),
          _buildFeatureTile(
            icon: Icons.verified_outlined,
            title: 'Konfirmasi Serah Terima & Bukti Foto',
            description: 'Foto bukti fisik timbangan dan tanda tangan penerima saat barang sampai di lokasi dapur.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryNavy.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryNavy, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
