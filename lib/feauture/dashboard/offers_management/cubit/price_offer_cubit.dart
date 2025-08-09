import 'package:ankh_project/domain/use_cases/update_price_offer_status_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/price_offer_status_update_entity.dart';
import '../../../../domain/use_cases/get_pending_price_offers_usecase.dart';
import 'price_offer_state.dart';
import '../../../../domain/entities/price_offer_pending_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class PriceOfferCubit extends Cubit<PriceOfferState> {
  final GetPendingPriceOffersUseCase getPendingPriceOffersUseCase;
  final UpdatePriceOfferStatusUseCase updatePriceOfferStatusUseCase; // ✅ Injected


  PriceOfferCubit(this.getPendingPriceOffersUseCase, this.updatePriceOfferStatusUseCase) : super(PriceOfferInitial());

  Future<void> fetchPendingPriceOffers() async {
    emit(PriceOfferLoading());
    try {
      final offers = await getPendingPriceOffersUseCase();
      emit(PriceOfferLoaded(offers));
    } catch (e) {
      emit(PriceOfferError(e.toString()));
    }
  }

  Future<void> updatePriceOfferStatus({
    required String id,
    required int status,
    required String adminNote,
  }) async {
    emit(PriceOfferStatusUpdating());

    try {
      final entity = PriceOfferStatusUpdateEntity(
        status: status,
        adminNote: adminNote,
      );
      print("Sending request...");
      await updatePriceOfferStatusUseCase(id, entity);
      await fetchPendingPriceOffers();// ✅ USE THE INSTANCE
      emit(PriceOfferStatusUpdated());
    } catch (e) {
      emit(PriceOfferStatusUpdateError(e.toString()));
    }
  }
}
