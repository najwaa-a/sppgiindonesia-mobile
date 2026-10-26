/// Entity Pesanan Masuk (Sales Order) bagi Supplier
class SalesOrderItem {
  final String itemName;
  final double requestedQuantity;
  final String unit;
  final bool isChecked;

  const SalesOrderItem({
    required this.itemName,
    required this.requestedQuantity,
    required this.unit,
    this.isChecked = false,
  });
}

class SalesOrder {
  final String id;
  final String kitchenName;
  final String deliveryTime;
  final String status; // PENDING, PROCESSING, READY FOR DELIVERY
  final List<SalesOrderItem> items;

  const SalesOrder({
    required this.id,
    required this.kitchenName,
    required this.deliveryTime,
    required this.status,
    required this.items,
  });
}
