import 'package:ankh_project/feauture/client_search_screen/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/all_products_entity.dart';
import '../../../domain/use_cases/get_all_products_use_case.dart';

@injectable
class AllProductsSearchCubit extends Cubit<AllProductsSearchState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  List<AllProductsEntity> _allProducts = [];

  AllProductsSearchCubit(this.getAllProductsUseCase) : super(AllProductsInitial());

  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());
    try {
      _allProducts = await getAllProductsUseCase();
      emit(AllProductsLoaded(allProducts: _allProducts, filteredProducts: _allProducts));
    } catch (e) {
      emit(AllProductsError(e.toString()));
    }
  }

  void search(String query) {
    if (state is AllProductsLoaded) {
      final filtered = _allProducts.where((product) {
        return product.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
      emit(AllProductsLoaded(allProducts: _allProducts, filteredProducts: filtered));
    }
  }
}
