import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/products_by_brand_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByBrandUseCase {
  final ProductsByBrandRepository repository;

  GetProductsByBrandUseCase(this.repository);

  Future<List<AllProductsEntity>> call(int brandId) {
    return repository.getProductsByBrandId(brandId);
  }
}