import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';

/// Layar Daftar Pesanan Masuk (PO dari Dapur) bagi Supplier
class IncomingOrdersScreen extends StatelessWidget {
  const IncomingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk dari Dapur'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderCard(
            context: context,
            orderId: 'PO-20261026-001',
            kitchenName: 'Dapur MBG Purwokerto 01',
            schedule: 'Besok Subuh (04.30 WIB)',
            status: 'PERLU DIPROSES',
            statusColor: AppColors.accentAmber,
            items: [
              'Beras Rojolele Super: 100 Kg',
              'Wortel Segar: 25 Kg',
            ],
          ),
          const SizedBox(height: 16),
          _buildOrderCard(
            context: context,
            orderId: 'PO-20261026-002',
            kitchenName: 'Dapur MBG Banyumas 02',
            schedule: 'Besok Pagi (06.00 WIB)',
            status: 'DIKEMAS',
            statusColor: Colors.blue,
            items: [
              'Ayam Broiler Utuh: 80 Kg',
              'Telur Ayam Ras: 40 Kg',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required BuildContext context,
    required String orderId,
    required String kitchenName,
    required String schedule,
    required String status,
    required Color statusColor,
    required List<String> items,
  }) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(kitchenName, style: AppTextStyles.headingSmall.copyWith(fontSize: 15)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(schedule, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
          const Divider(height: 20),
          const Text('Checklist Item Bahan:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 6),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_box_outline_blank, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(item, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => context.push('/supplier/shipment'),
                child: const Text('Siapkan Pengiriman'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
