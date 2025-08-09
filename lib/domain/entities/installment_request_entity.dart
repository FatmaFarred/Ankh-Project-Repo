class InstallmentRequestEntity {
  final String marketerId;
  final int productId;
  final String clientName;
  final String clientPhone;
  final int installmentPeriod;
  final int downPayment;

  InstallmentRequestEntity({
    required this.marketerId,
    required this.productId,
    required this.clientName,
    required this.clientPhone,
    required this.installmentPeriod,
    required this.downPayment,
  });
}
