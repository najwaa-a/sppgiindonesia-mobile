/// Entity Konfirmasi Penerimaan Bahan di Dapur MBG
class ReceiptConfirmation {
  final String orderId;
  final int beneficiaryCount; // Jumlah penerima manfaat (siswa) yang hadir
  final Map<String, double> receivedQuantities; // nama bahan -> kuantitas fisik diterima
  final String receiverName;
  final String? notes;
  final DateTime receivedAt;

  const ReceiptConfirmation({
    required this.orderId,
    required this.beneficiaryCount,
    required this.receivedQuantities,
    required this.receiverName,
    this.notes,
    required this.receivedAt,
  });
}
