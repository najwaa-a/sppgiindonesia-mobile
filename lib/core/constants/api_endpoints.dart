/// Definisi Endpoint RESTful API SPPGIndonesia Backend Laravel
class ApiEndpoints {
  // Autentikasi
  static const String register = '/register';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String profile = '/profile';

  // Bahan Pangan & Katalog
  static const String products = '/product';
  static const String categories = '/categories';

  // Dapur MBG (Purchase Order & Penerimaan)
  static const String purchases = '/purchases';
  static const String receiptConfirmations = '/receipt-confirmations';

  // Supplier (Pesanan Masuk & Pengiriman)
  static const String salesOrders = '/sales-orders';
  static String updateShipmentStatus(int id) => '/shipments/$id';
  static String uploadProofOfDelivery(int id) => '/shipments/$id/proof';
}
