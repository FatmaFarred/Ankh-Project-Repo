class InstallmentPendingEntity {
  final int id;
  final String marketerName;
  final String productName;
  final String productImage;
  final String clientName;
  final String clientPhone;
  final String productPrice;
  final int requestedMonths;
  final double downPayment;
  final String status;
  final DateTime createdAt;
  final String? adminNote;
  final DateTime? processedAt;

  InstallmentPendingEntity({
    required this.id,
    required this.marketerName,
    required this.productName,
    required this.productImage,
    required this.clientName,
    required this.clientPhone,
    required this.productPrice,
    required this.requestedMonths,
    required this.downPayment,
    required this.status,
    required this.createdAt,
    this.adminNote,
    this.processedAt,
  });
}
