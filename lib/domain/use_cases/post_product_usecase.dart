import 'package:injectable/injectable.dart';

import '../entities/product_post_entity.dart';
import '../repositries_and_data_sources/repositries/post_product_repository.dart';

@injectable

class PostProductUseCase {
  final PostProductRepository repository;

  PostProductUseCase(this.repository);

  Future<void> call(ProductPostEntity entity) async {
    await repository.postProduct(entity);
  }
}
