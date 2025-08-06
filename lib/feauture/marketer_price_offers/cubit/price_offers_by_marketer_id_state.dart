part of 'price_offers_by_marketer_id_cubit.dart';

abstract class PriceOffersByMarketerIdState {}

class PriceOffersByMarketerIdInitial extends PriceOffersByMarketerIdState {}

class PriceOffersByMarketerIdLoading extends PriceOffersByMarketerIdState {}

class PriceOffersByMarketerIdLoaded extends PriceOffersByMarketerIdState {
  final List<PriceOffersByMarketerIdEntity> offers;

  PriceOffersByMarketerIdLoaded(this.offers);
}

class PriceOffersByMarketerIdError extends PriceOffersByMarketerIdState {
  final String message;

  PriceOffersByMarketerIdError(this.message);
}
