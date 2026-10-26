/// Entity Bukti Serah Terima (Proof of Delivery)
class ProofOfDelivery {
  final String shipmentId;
  final String recipientName;
  final String? photoPath;
  final String? notes;
  final DateTime submittedAt;

  const ProofOfDelivery({
    required this.shipmentId,
    required this.recipientName,
    this.photoPath,
    this.notes,
    required this.submittedAt,
  });
}
