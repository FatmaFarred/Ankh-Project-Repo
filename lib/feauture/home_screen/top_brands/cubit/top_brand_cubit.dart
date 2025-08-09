import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ankh_project/domain/entities/top_brand_entity.dart';
import 'package:ankh_project/domain/use_cases/get_top_brands_use_case.dart';

part 'top_brand_state.dart';

@injectable // <--- this is the key line
class TopBrandCubit extends Cubit<TopBrandState> {
  final GetTopBrandsUseCase getTopBrandsUseCase;

  TopBrandCubit(this.getTopBrandsUseCase) : super(TopBrandInitial());

  Future<void> fetchTopBrands() async {
    emit(TopBrandLoading());
    try {
      final brands = await getTopBrandsUseCase();
      emit(TopBrandLoaded(brands));
    } catch (e) {
      emit(TopBrandError('Failed to load brands'));
    }
  }
}
