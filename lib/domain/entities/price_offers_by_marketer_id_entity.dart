class PriceOffersByMarketerIdEntity {
  final int id;
  final String marketerName;
  final String productName;
  final String productImage;
  final String clientName;
  final String clientPhone;
  final int inspectorPoints;
  final DateTime createdAt;
  final String status;
  final double requestedPrice;
  final String? adminNote;
  final DateTime? processedAt;

  const PriceOffersByMarketerIdEntity({
    required this.id,
    required this.marketerName,
    required this.productName,
    required this.productImage,
    required this.clientName,
    required this.clientPhone,
    required this.inspectorPoints,
    required this.createdAt,
    required this.status,
    required this.requestedPrice,
    this.adminNote,
    this.processedAt,
  });
}
