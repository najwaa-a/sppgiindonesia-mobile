import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';

/// Layar Konfirmasi Penerimaan Bahan oleh Petugas Dapur MBG
class ReceiptConfirmationScreen extends StatefulWidget {
  const ReceiptConfirmationScreen({super.key});

  @override
  State<ReceiptConfirmationScreen> createState() => _ReceiptConfirmationScreenState();
}

class _ReceiptConfirmationScreenState extends State<ReceiptConfirmationScreen> {
  final _beneficiaryController = TextEditingController(text: '350');
  final _receiverController = TextEditingController(text: 'Koki Budi Santoso');
  final _riceQtyController = TextEditingController(text: '50');
  final _chickenQtyController = TextEditingController(text: '40');

  @override
  void dispose() {
    _beneficiaryController.dispose();
    _receiverController.dispose();
    _riceQtyController.dispose();
    _chickenQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Penerimaan Bahan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Surat Jalan
            CustomCard(
              color: AppColors.primaryNavy.withValues(alpha: 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Surat Jalan: SJ-20261026-091',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accentAmber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('TERKUNCI DI JALAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('Kurir: Ahmad (Armada PickUp AA 1234 XY)', style: TextStyle(fontSize: 12)),
                  const Text('Supplier: Koperasi Tani Makmur', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Perbandingan Kuantitas Surat Jalan vs Fisik Diterima
            Text('Verifikasi Kuantitas Fisik (Timbangan)', style: AppTextStyles.headingSmall),
            const SizedBox(height: 4),
            const Text(
              'Pastikan kuantitas fisik yang ditimbang di dapur sesuai atau catat bila terjadi selisih.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),

            _buildQtyComparisonItem(
              title: 'Beras Rojolele Super',
              sentQty: '50 Kg (Surat Jalan)',
              controller: _riceQtyController,
              unit: 'Kg',
            ),
            const SizedBox(height: 12),
            _buildQtyComparisonItem(
              title: 'Ayam Broiler Utuh',
              sentQty: '40 Kg (Surat Jalan)',
              controller: _chickenQtyController,
              unit: 'Kg',
            ),
            const SizedBox(height: 24),

            // Jumlah Penerima Manfaat
            Text('Data Operasional Sekolah / MBG', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            TextFormField(
              controller: _beneficiaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Penerima Manfaat (Siswa) Hadir',
                prefixIcon: Icon(Icons.groups_outlined),
                helperText: 'Digunakan untuk kalkulasi rasio kecukupan gizi harian',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _receiverController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas Penerima Dapur',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              label: 'Konfirmasi Serah Terima Selesai',
              icon: Icons.check_circle_outline,
              backgroundColor: AppColors.successGreen,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Penerimaan bahan berhasil dikonfirmasi dan status pesanan COMPLETED!'),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyComparisonItem({
    required String title,
    required String sentQty,
    required TextEditingController controller,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(sentQty, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                suffixText: unit,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
