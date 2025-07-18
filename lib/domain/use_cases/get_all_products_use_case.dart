import 'package:ankh_project/domain/repositries_and_data_sources/repositries/all_products_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/all_products_entity.dart';
@injectable
class GetAllProductsUseCase {
  final AllProductsRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<List<AllProductsEntity>> call() {
    return repository.getAllProducts();
  }
}
