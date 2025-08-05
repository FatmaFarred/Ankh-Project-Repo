import '../../../../domain/entities/price_offer_pending_entity.dart';

abstract class PriceOfferState {}

class PriceOfferInitial extends PriceOfferState {}

class PriceOfferLoading extends PriceOfferState {}

class PriceOfferLoaded extends PriceOfferState {
  final List<PriceOfferPendingEntity> offers;

  PriceOfferLoaded(this.offers);
}

class PriceOfferError extends PriceOfferState {
  final String message;

  PriceOfferError(this.message);
}

// 🔄 Status Update States

class PriceOfferStatusUpdating extends PriceOfferState {}

class PriceOfferStatusUpdated extends PriceOfferState {}

class PriceOfferStatusUpdateError extends PriceOfferState {
  final String message;

  PriceOfferStatusUpdateError(this.message);
}

