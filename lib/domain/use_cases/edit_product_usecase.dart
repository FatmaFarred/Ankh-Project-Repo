import 'package:injectable/injectable.dart';
import '../entities/product_post_entity.dart';
import '../repositries_and_data_sources/repositries/post_product_repository.dart';

@injectable
class EditProductUseCase {
  final PostProductRepository repository;

  EditProductUseCase(this.repository);

  Future<void> call({
    required int productId,
    required ProductPostEntity entity,
  }) {
    return repository.editProduct(productId, entity);
  }
}
