import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/domain/entities/price_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/use_cases/price_offers_by_marketer_id_usecase.dart';
import 'package:injectable/injectable.dart';

part 'price_offers_by_marketer_id_state.dart';

@injectable
class PriceOffersByMarketerIdCubit extends Cubit<PriceOffersByMarketerIdState> {
  final GetPriceOffersByMarketerIdUseCase getOffers;

  PriceOffersByMarketerIdCubit(this.getOffers)
      : super(PriceOffersByMarketerIdInitial());

  Future<void> fetchOffers(String marketerId) async {
    print("Cubit: Starting to fetch offers for marketer ID: $marketerId");
    emit(PriceOffersByMarketerIdLoading());
    try {
      final offers = await getOffers(marketerId);
      print("Cubit: Successfully fetched ${offers.length} offers");
      emit(PriceOffersByMarketerIdLoaded(offers));
    } catch (e) {
      print("Cubit: Error fetching offers: $e");
      emit(PriceOffersByMarketerIdError(e.toString()));
    }
  }
}
