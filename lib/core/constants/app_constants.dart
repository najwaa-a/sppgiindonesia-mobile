/// Konstanta umum aplikasi SPPGIndonesia Mobile
class AppConstants {
  static const String appName = 'SPPGIndonesia';
  static const String appVersion = '1.0.0';

  // Role Pengguna
  static const String roleKitchen = 'kitchen'; // Dapur MBG
  static const String roleSupplier = 'supplier'; // Supplier

  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserRole = 'user_role';
  static const String keyUserData = 'user_data';

  // Status Pesanan (State Machine SDD)
  static const String statusDraft = 'DRAFT';
  static const String statusPending = 'PENDING';
  static const String statusProcessing = 'PROCESSING';
  static const String statusReadyForDelivery = 'READY FOR DELIVERY';
  static const String statusOnDelivery = 'ON DELIVERY';
  static const String statusCompleted = 'COMPLETED';
  static const String statusCancelled = 'CANCELLED';
}
