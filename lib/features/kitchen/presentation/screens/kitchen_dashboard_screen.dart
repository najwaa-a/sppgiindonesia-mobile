import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';

/// Dashboard Utama Role Dapur MBG (Mitra Dapur)
class KitchenDashboardScreen extends StatefulWidget {
  const KitchenDashboardScreen({super.key});

  @override
  State<KitchenDashboardScreen> createState() => _KitchenDashboardScreenState();
}

class _KitchenDashboardScreenState extends State<KitchenDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dapur MBG Purwokerto 01',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Petugas: Koki Lapangan',
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
            // Status Produksi Masak Hari Ini
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Target Masak Esok Hari',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentAmber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '1.200 Porsi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Menu: Nasi Ayam Suwir & Sayur Sop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Status Bahan: Menunggu 2 pengiriman supplier',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Aksi Cepat
            Text('Aksi Cepat Dapur', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: 'Katalog Bahan',
                    icon: Icons.inventory_2_outlined,
                    color: AppColors.primaryNavy,
                    onTap: () => context.push('/kitchen/catalog'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    title: 'Buat PO',
                    icon: Icons.add_shopping_cart,
                    color: AppColors.accentAmber,
                    onTap: () => context.push('/kitchen/purchase-order'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              title: 'Konfirmasi Penerimaan Barang',
              subtitle: 'Verifikasi surat jalan kurir & timbangan di lokasi',
              icon: Icons.assignment_turned_in_outlined,
              color: AppColors.successGreen,
              onTap: () => context.push('/kitchen/receipt-confirmation'),
            ),
            const SizedBox(height: 24),

            // Pengiriman Aktif
            Text('Status Pengiriman Berjalan', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PO-20261026-001',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'ON DELIVERY',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Supplier: Koperasi Peternak Mandiri',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Item: Ayam Potong 60 Kg, Telur 30 Kg',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimasi tiba: 05:00 WIB',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      TextButton(
                        onPressed: () => context.push('/kitchen/receipt-confirmation'),
                        child: const Text('Konfirmasi Tiba >'),
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
          if (index == 1) context.push('/kitchen/catalog');
          if (index == 2) context.push('/kitchen/purchase-order');
          if (index == 3) context.push('/kitchen/receipt-confirmation');
        },
        selectedItemColor: AppColors.primaryNavy,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'PO Baru'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Penerimaan'),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    String? subtitle,
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}
