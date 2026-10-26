import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';

/// Dashboard Utama Role Mitra Supplier Pangan
class SupplierDashboardScreen extends StatefulWidget {
  const SupplierDashboardScreen({super.key});

  @override
  State<SupplierDashboardScreen> createState() => _SupplierDashboardScreenState();
}

class _SupplierDashboardScreenState extends State<SupplierDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Koperasi Tani Makmur',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Supplier Pangan Terverifikasi',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.8)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Ringkasan Pengiriman Hari Ini
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.secondaryNavy, AppColors.darkNavy],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengantaran Bahan Hari Ini',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '3 Pesanan Masuk (2 Wajib Subuh)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentAmber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '1 Sedang Dikirim',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '2 Perlu Dikemas',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Fitur Supplier Lapangan
            Text('Manajemen Order Supplier', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSupplierTile(
                    title: 'Pesanan Masuk',
                    subtitle: 'Checklist PO dari Dapur',
                    icon: Icons.inbox_outlined,
                    color: AppColors.primaryNavy,
                    onTap: () => context.push('/supplier/incoming-orders'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSupplierTile(
                    title: 'Status Pengiriman',
                    subtitle: 'Kemas & Kirim Armada',
                    icon: Icons.local_shipping_outlined,
                    color: AppColors.accentAmber,
                    onTap: () => context.push('/supplier/shipment'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSupplierTile(
              title: 'Upload Bukti Serah Terima (PoD)',
              subtitle: 'Foto bukti timbangan & tanda tangan penerima di dapur',
              icon: Icons.camera_alt_outlined,
              color: AppColors.successGreen,
              onTap: () => context.push('/supplier/proof-of-delivery'),
            ),
            const SizedBox(height: 24),

            // Order Terdekat
            Text('Jadwal Pengantaran Prioritas', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dapur MBG Purwokerto 01',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentAmber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Tiba 04:30 WIB',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Barang: Beras Rojolele 100 Kg, Wortel 25 Kg', style: TextStyle(fontSize: 13)),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status: Diproses', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ElevatedButton(
                        onPressed: () => context.push('/supplier/shipment'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          minimumSize: Size.zero,
                        ),
                        child: const Text('Update Status', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) context.push('/supplier/incoming-orders');
          if (index == 2) context.push('/supplier/shipment');
          if (index == 3) context.push('/supplier/proof-of-delivery');
        },
        selectedItemColor: AppColors.primaryNavy,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Order Masuk'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Pengiriman'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Bukti Kirim'),
        ],
      ),
    );
  }

  Widget _buildSupplierTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              radius: 20,
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}
