class PriceOfferPendingEntity {
  final int id;
  final String marketerName;
  final String productName;
  final String productImage;
  final String clientName;
  final String clientPhone;
  final DateTime createdAt;
  final String status;
  final double requestedPrice;

  const PriceOfferPendingEntity({
    required this.id,
    required this.marketerName,
    required this.productName,
    required this.productImage,
    required this.clientName,
    required this.clientPhone,
    required this.createdAt,
    required this.status,
    required this.requestedPrice,
  });
}
