/// Definisi nama tabel, relasi, dan storage bucket pada Supabase (PostgreSQL)
class SupabaseTables {
  // Tabel Entitas & Pengguna
  static const String profiles = 'profiles'; // profil user & role (kitchen / supplier)

  // Tabel Katalog & Bahan Pangan
  static const String products = 'products'; // daftar bahan pangan
  static const String categories = 'categories'; // kategori bahan baku

  // Tabel Transaksi Dapur (Purchase Order)
  static const String purchaseOrders = 'purchase_orders';
  static const String purchaseOrderItems = 'purchase_order_items';

  // Tabel Pengiriman & Logistik Supplier
  static const String shipments = 'shipments'; // status & surat jalan digital

  // Tabel Serah Terima & Konfirmasi Dapur
  static const String receiptConfirmations = 'receipt_confirmations';

  // Storage Buckets Supabase
  static const String bucketProofOfDelivery = 'proof_of_delivery'; // foto timbangan serah terima
  static const String bucketProductImages = 'product_images'; // foto bahan pangan
}
