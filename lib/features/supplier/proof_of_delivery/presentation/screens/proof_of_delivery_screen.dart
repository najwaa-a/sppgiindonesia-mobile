import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';

/// Layar Bukti Serah Terima (Proof of Delivery) dengan input foto timbangan dan nama penerima
class ProofOfDeliveryScreen extends StatefulWidget {
  const ProofOfDeliveryScreen({super.key});

  @override
  State<ProofOfDeliveryScreen> createState() => _ProofOfDeliveryScreenState();
}

class _ProofOfDeliveryScreenState extends State<ProofOfDeliveryScreen> {
  final _recipientController = TextEditingController(text: 'Koki Budi Santoso');
  final _notesController = TextEditingController();
  bool _hasPhoto = false;

  @override
  void dispose() {
    _recipientController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Serah Terima (PoD)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dokumentasi Penyerahan Bahan', style: AppTextStyles.headingSmall),
            const SizedBox(height: 6),
            const Text(
              'Unggah foto bukti timbangan fisik di dapur dan catat nama petugas penerima.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),

            // Area Foto Bukti Fisik
            InkWell(
              onTap: () {
                setState(() => _hasPhoto = !_hasPhoto);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_hasPhoto ? 'Foto bukti berhasil diambil!' : 'Foto dihapus'),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: _hasPhoto ? AppColors.successGreen.withValues(alpha: 0.08) : AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _hasPhoto ? AppColors.successGreen : AppColors.divider,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _hasPhoto ? Icons.check_circle : Icons.camera_alt_outlined,
                        size: 48,
                        color: _hasPhoto ? AppColors.successGreen : AppColors.primaryNavy,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _hasPhoto
                            ? 'Foto Timbangan Fisik Terlampir (Klik untuk ubah)'
                            : 'Ketuk untuk Ambil Foto dari Kamera',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _hasPhoto ? AppColors.successGreen : AppColors.primaryNavy,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Format JPG/PNG maks. 5MB',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nama Penerima
            TextFormField(
              controller: _recipientController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas Dapur Penerima',
                prefixIcon: Icon(Icons.person_pin_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Catatan Tambahan
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Catatan Serah Terima (Opsional)',
                hintText: 'Contoh: Karung beras dalam kondisi kering dan rapi.',
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              label: 'Kirim Bukti Serah Terima',
              icon: Icons.cloud_upload_outlined,
              backgroundColor: AppColors.primaryNavy,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bukti serah terima berhasil diunggah! Status pengiriman selesai.'),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
                context.go('/supplier/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
