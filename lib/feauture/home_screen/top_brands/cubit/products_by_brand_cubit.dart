import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/use_cases/get_products_by_brand_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'products_by_brand_state.dart';

@injectable
class ProductsByBrandCubit extends Cubit<ProductsByBrandState> {
  final GetProductsByBrandUseCase getProductsByBrandUseCase;

  ProductsByBrandCubit(this.getProductsByBrandUseCase)
      : super(ProductsByBrandInitial());

  Future<void> getProductsByBrandId(int brandId) async {
    emit(ProductsByBrandLoading());

    try {
      final products = await getProductsByBrandUseCase(brandId);
      if (products.isEmpty) {
        emit(ProductsByBrandEmpty());
      } else {
        emit(ProductsByBrandLoaded(products));
      }
    } catch (e) {
      emit(ProductsByBrandError(e.toString()));
    }
  }
}