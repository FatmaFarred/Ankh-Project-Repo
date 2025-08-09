part of 'installment_offers_by_marketer_id_cubit.dart';

abstract class InstallmentOffersByMarketerIdState {}

class InstallmentOffersByMarketerIdInitial extends InstallmentOffersByMarketerIdState {}

class InstallmentOffersByMarketerIdLoading extends InstallmentOffersByMarketerIdState {}

class InstallmentOffersByMarketerIdLoaded extends InstallmentOffersByMarketerIdState {
  final List<InstallmentOffersByMarketerIdEntity> offers;

  InstallmentOffersByMarketerIdLoaded(this.offers);
}

class InstallmentOffersByMarketerIdError extends InstallmentOffersByMarketerIdState {
  final String message;

  InstallmentOffersByMarketerIdError(this.message);
} 