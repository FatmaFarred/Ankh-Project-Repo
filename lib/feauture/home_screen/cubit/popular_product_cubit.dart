import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_popular_products_use_case.dart';

part 'popular_product_state.dart';

class PopularProductsCubit extends Cubit<PopularProductsState> {
  final GetPopularProductsUseCase useCase;

  PopularProductsCubit(this.useCase) : super(PopularProductsInitial());

  void fetchPopularProducts() async {
    emit(PopularProductsLoading());
    try {
      final products = await useCase();
      emit(PopularProductsLoaded(products));
    } catch (e) {
      emit(PopularProductsError("Failed to load products"));
    }
  }
}
