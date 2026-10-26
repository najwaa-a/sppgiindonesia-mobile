/// Entity untuk bahan pangan pada katalog dapur
class CatalogItem {
  final int id;
  final String name;
  final String category;
  final double price;
  final String unit; // Kg, Ikat, Karung, Butir
  final double stock;
  final String supplierName;

  const CatalogItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.stock,
    required this.supplierName,
  });
}
