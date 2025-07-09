import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_recommended_brands_use_case.dart';

part 'recommended_brands_state.dart';

class RecommendedBrandsCubit extends Cubit<RecommendedBrandsState> {
  final GetRecommendedBrandsUseCase useCase;

  RecommendedBrandsCubit(this.useCase) : super(RecommendedBrandsInitial());

  void fetchRecommendedBrands() async {
    emit(RecommendedBrandsLoading());
    try {
      final brands = await useCase();
      emit(RecommendedBrandsLoaded(brands));
    } catch (e) {
      emit(RecommendedBrandsError("Failed to load recommended brands"));
    }
  }
}
