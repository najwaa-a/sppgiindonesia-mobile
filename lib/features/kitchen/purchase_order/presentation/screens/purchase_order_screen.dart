import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';

/// Layar Pembuatan Purchase Order (PO) Bahan Dapur
class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  String _selectedSupplier = 'Koperasi Tani Makmur';
  String _deliveryTime = 'Subuh (04.30 WIB)';
  String _paymentMethod = 'Pembayaran Penuh';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Purchase Order Baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informasi Pengadaan Masak', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),

            // Pilih Supplier
            DropdownButtonFormField<String>(
              initialValue: _selectedSupplier,
              decoration: const InputDecoration(labelText: 'Pilih Supplier Rekanan'),
              items: const [
                DropdownMenuItem(value: 'Koperasi Tani Makmur', child: Text('Koperasi Tani Makmur')),
                DropdownMenuItem(value: 'Koperasi Peternak Mandiri', child: Text('Koperasi Peternak Mandiri')),
                DropdownMenuItem(value: 'Kelompok Tani Sayur Segar', child: Text('Kelompok Tani Sayur Segar')),
              ],
              onChanged: (v) => setState(() => _selectedSupplier = v!),
            ),
            const SizedBox(height: 16),

            // Jam Kirim Wajib
            DropdownButtonFormField<String>(
              initialValue: _deliveryTime,
              decoration: const InputDecoration(labelText: 'Jadwal Pengantaran ke Dapur'),
              items: const [
                DropdownMenuItem(value: 'Subuh (04.30 WIB)', child: Text('Subuh (04.30 WIB) - Prioritas')),
                DropdownMenuItem(value: 'Pagi (06.00 WIB)', child: Text('Pagi (06.00 WIB)')),
                DropdownMenuItem(value: 'Siang (11.00 WIB)', child: Text('Siang (11.00 WIB)')),
              ],
              onChanged: (v) => setState(() => _deliveryTime = v!),
            ),
            const SizedBox(height: 16),

            // Metode Pembayaran
            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(labelText: 'Metode Pembayaran'),
              items: const [
                DropdownMenuItem(value: 'Pembayaran Penuh', child: Text('Pembayaran Penuh')),
                DropdownMenuItem(value: 'Termin Parsial (Tempo 7 Hari)', child: Text('Termin Parsial (Tempo 7 Hari)')),
              ],
              onChanged: (v) => setState(() => _paymentMethod = v!),
            ),
            const SizedBox(height: 24),

            // Ringkasan Daftar Barang
            Text('Daftar Item Bahan yang Dipesan', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  _buildItemRow('Beras Rojolele Super', '100 Kg', 'Rp 1.450.000'),
                  const Divider(height: 20),
                  _buildItemRow('Ayam Broiler Utuh', '50 Kg', 'Rp 1.800.000'),
                  const Divider(height: 20),
                  _buildItemRow('Wortel Segar', '25 Kg', 'Rp 300.000'),
                  const Divider(height: 24, thickness: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Estimasi Biaya PO:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text(
                        'Rp 3.550.000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              label: 'Kirim Purchase Order ke Supplier',
              icon: Icons.send_outlined,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Purchase Order berhasil diterbitkan ke Supplier!'),
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

  Widget _buildItemRow(String name, String qty, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(qty, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
