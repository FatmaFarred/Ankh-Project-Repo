import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/product_management_repository.dart';

@injectable
class DeleteProductUseCase {
  final ProductManagementRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> call(int productId) {
    return repository.deleteProduct(productId);
  }
}
