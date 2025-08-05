  class PriceOfferRequestEntity {
    final String marketerId;
    final int productId;
    final String clientName;
    final String clientPhone;
    final int requestedPrice;

    const PriceOfferRequestEntity({
      required this.marketerId,
      required this.productId,
      required this.clientName,
      required this.clientPhone,
      required this.requestedPrice,
    });
  }
