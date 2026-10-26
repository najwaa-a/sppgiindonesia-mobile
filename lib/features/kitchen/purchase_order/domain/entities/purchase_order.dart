/// Entity Purchase Order untuk Dapur MBG
class PurchaseOrderItem {
  final String itemName;
  final double quantity;
  final String unit;
  final double pricePerUnit;

  const PurchaseOrderItem({
    required this.itemName,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
  });

  double get subtotal => quantity * pricePerUnit;
}

class PurchaseOrder {
  final String id;
  final String kitchenName;
  final String supplierName;
  final DateTime deliveryDate;
  final String deliveryTime; // e.g. "04:30 WIB"
  final String status;
  final List<PurchaseOrderItem> items;

  const PurchaseOrder({
    required this.id,
    required this.kitchenName,
    required this.supplierName,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.status,
    required this.items,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.subtotal);
}
