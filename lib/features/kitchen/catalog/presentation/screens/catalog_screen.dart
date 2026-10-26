import 'package:flutter/material.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/utils/formatters.dart';
import 'package:posmbg_mobile/core/widgets/custom_card.dart';
import 'package:posmbg_mobile/features/kitchen/catalog/domain/entities/catalog_item.dart';

/// Layar Katalog Bahan Baku untuk Dapur MBG
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Beras & Pokok', 'Daging & Ayam', 'Sayur Segar', 'Bumbu'];

  final List<CatalogItem> _dummyItems = const [
    CatalogItem(
      id: 1,
      name: 'Beras Rojolele Super',
      category: 'Beras & Pokok',
      price: 14500,
      unit: 'Kg',
      stock: 500,
      supplierName: 'Koperasi Tani Makmur',
    ),
    CatalogItem(
      id: 2,
      name: 'Ayam Broiler Utuh Bersih',
      category: 'Daging & Ayam',
      price: 36000,
      unit: 'Kg',
      stock: 120,
      supplierName: 'Koperasi Peternak Mandiri',
    ),
    CatalogItem(
      id: 3,
      name: 'Wortel Brastagi Segar',
      category: 'Sayur Segar',
      price: 12000,
      unit: 'Kg',
      stock: 80,
      supplierName: 'Kelompok Tani Sayur Segar',
    ),
    CatalogItem(
      id: 4,
      name: 'Bawang Merah Brebes',
      category: 'Bumbu',
      price: 32000,
      unit: 'Kg',
      stock: 50,
      supplierName: 'Grosir Sembako Berkah',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedCategory == 'Semua'
        ? _dummyItems
        : _dummyItems.where((i) => i.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Bahan Baku Segar'),
      ),
      body: Column(
        children: [
          // Filter Kategori
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(cat),
                    selectedColor: AppColors.primaryNavy.withValues(alpha: 0.15),
                    checkmarkColor: AppColors.primaryNavy,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),

          // Daftar Item
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSecondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.lunch_dining_outlined, color: AppColors.primaryNavy),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: AppTextStyles.headingSmall.copyWith(fontSize: 15)),
                              const SizedBox(height: 2),
                              Text(
                                '${item.supplierName} • Stok: ${item.stock.toInt()} ${item.unit}',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${AppFormatters.formatRupiah(item.price)} / ${item.unit}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryNavy,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.name} ditambahkan ke pesanan PO')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            minimumSize: Size.zero,
                          ),
                          child: const Text('+ PO', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
