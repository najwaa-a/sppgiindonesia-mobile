import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/constants/app_constants.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';

/// Layar Pembaruan Status Pengiriman dan Surat Jalan Digital
class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key});

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  String _currentStatus = AppConstants.statusProcessing;
  final _driverController = TextEditingController(text: 'Ahmad Faisal');
  final _vehicleController = TextEditingController(text: 'AA 1234 XY (Pick Up)');

  @override
  void dispose() {
    _driverController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status & Surat Jalan Pengiriman'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Surat Jalan
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Surat Jalan: SJ-20261026-091', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _currentStatus,
                          style: const TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('Tujuan: Dapur MBG Purwokerto 01', style: TextStyle(fontSize: 13)),
                  const Text('Target Tiba: 04:30 WIB (Prioritas)', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Alur State Machine Status
            Text('Progres Status Pengiriman', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            _buildStatusStep('1. Diproses (PROCESSING)', _currentStatus == AppConstants.statusProcessing, () {
              setState(() => _currentStatus = AppConstants.statusProcessing);
            }),
            _buildStatusStep('2. Dikemas (READY FOR DELIVERY)', _currentStatus == AppConstants.statusReadyForDelivery, () {
              setState(() => _currentStatus = AppConstants.statusReadyForDelivery);
            }),
            _buildStatusStep('3. Dikirim / Armada Berangkat (ON DELIVERY)', _currentStatus == AppConstants.statusOnDelivery, () {
              setState(() => _currentStatus = AppConstants.statusOnDelivery);
            }),
            const SizedBox(height: 24),

            // Data Armada & Kuantitas Terkunci
            Text('Data Armada & Kuantitas Terkunci', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            TextFormField(
              controller: _driverController,
              decoration: const InputDecoration(labelText: 'Nama Pengemudi / Kurir'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _vehicleController,
              decoration: const InputDecoration(labelText: 'Nomor Plat & Jenis Kendaraan'),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock_outline, size: 16, color: AppColors.primaryNavy),
                      SizedBox(width: 6),
                      Text('Kuantitas Terkunci Surat Jalan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('• Beras Rojolele Super: 100 Kg', style: TextStyle(fontSize: 12)),
                  Text('• Wortel Segar: 25 Kg', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            CustomButton(
              label: 'Simpan & Berangkatkan Armada',
              icon: Icons.local_shipping,
              onPressed: () {
                setState(() => _currentStatus = AppConstants.statusOnDelivery);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Armada berhasil diberangkatkan! Status berubah ke ON DELIVERY.'),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: 'Lanjut ke Upload Bukti Serah Terima',
              icon: Icons.camera_alt,
              isOutlined: true,
              onPressed: () => context.push('/supplier/proof-of-delivery'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String title, bool isActive, VoidCallback onSelect) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryNavy.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primaryNavy : AppColors.divider,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isActive ? AppColors.primaryNavy : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? AppColors.primaryNavy : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
