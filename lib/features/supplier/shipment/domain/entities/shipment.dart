/// Entity Pengiriman dan Surat Jalan bagi Supplier
class Shipment {
  final String shipmentId;
  final String orderId;
  final String kitchenName;
  final String driverName;
  final String vehicleNumber;
  final String status; // PROCESSING, READY FOR DELIVERY, ON DELIVERY, COMPLETED
  final DateTime departedAt;
  final Map<String, double> lockedQuantities; // kuantitas yang terkunci sejak berangkat

  const Shipment({
    required this.shipmentId,
    required this.orderId,
    required this.kitchenName,
    required this.driverName,
    required this.vehicleNumber,
    required this.status,
    required this.departedAt,
    required this.lockedQuantities,
  });
}
