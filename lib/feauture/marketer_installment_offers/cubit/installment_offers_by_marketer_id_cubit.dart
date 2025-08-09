import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/domain/entities/installment_offers_by_marketer_id_entity.dart';
import 'package:ankh_project/domain/use_cases/installment_offers_by_marketer_id_usecase.dart';
import 'package:injectable/injectable.dart';

part 'installment_offers_by_marketer_id_state.dart';

@injectable
class InstallmentOffersByMarketerIdCubit extends Cubit<InstallmentOffersByMarketerIdState> {
  final GetInstallmentOffersByMarketerIdUseCase getOffers;

  InstallmentOffersByMarketerIdCubit(this.getOffers)
      : super(InstallmentOffersByMarketerIdInitial());

  Future<void> fetchOffers(String marketerId) async {
    print("Cubit: Starting to fetch installment offers for marketer ID: $marketerId");
    emit(InstallmentOffersByMarketerIdLoading());
    try {
      final offers = await getOffers(marketerId);
      print("Cubit: Successfully fetched ${offers.length} installment offers");
      emit(InstallmentOffersByMarketerIdLoaded(offers));
    } catch (e) {
      print("Cubit: Error fetching installment offers: $e");
      emit(InstallmentOffersByMarketerIdError(e.toString()));
    }
  }
} 