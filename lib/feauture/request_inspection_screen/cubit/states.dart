import '../../../api_service/failure/error_handling.dart';

abstract class MarketerAddRequestState {}

class MarketerAddRequestInitial extends MarketerAddRequestState {}

class MarketerAddRequestLoading extends MarketerAddRequestState {}

class MarketerAddRequestSuccess extends MarketerAddRequestState {
  final String? response;
  MarketerAddRequestSuccess({required this.response});
}

class MarketerAddRequestError extends MarketerAddRequestState {
  final Failure error;
  MarketerAddRequestError({required this.error});
}

// -----------------------
// Price Offer States
// -----------------------

class PriceOfferRequestLoading extends MarketerAddRequestState {}

class PriceOfferRequestSuccess extends MarketerAddRequestState {}

class PriceOfferRequestError extends MarketerAddRequestState {
  final String error;
  PriceOfferRequestError({required this.error});
}


class InstallmentRequestLoading extends MarketerAddRequestState {}
class InstallmentRequestSuccess extends MarketerAddRequestState {}
class InstallmentRequestError extends MarketerAddRequestState {
  final String error;
  InstallmentRequestError({required this.error});
}
