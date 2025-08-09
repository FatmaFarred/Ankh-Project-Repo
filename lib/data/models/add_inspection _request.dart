class InspectionRequest {
  final String clientName;
  final String phoneNumber;
  final String address;
  final DateTime preferredDate;
  final String preferredTime;
  final int productId;
  final String marketerId;
  final num agreedPrice;


  InspectionRequest({
    required this.clientName,
    required this.phoneNumber,
    required this.address,
    required this.preferredDate,
    required this.preferredTime,
    required this.productId,
    required this.marketerId,
    required this.agreedPrice
  });

  Map<String, dynamic> toJson() {
    return {
      "clientName": clientName,
      "phoneNumber": phoneNumber,
      "address": address,
      "preferredDate": preferredDate.toIso8601String(), // Format: 2025-07-03T22:15:15.765Z
      "preferredTime": preferredTime, // Format: HH:mm:ss
      "productId": productId,
      "marketerId": marketerId,
      "agreedPrice": agreedPrice,
    };
  }
}
