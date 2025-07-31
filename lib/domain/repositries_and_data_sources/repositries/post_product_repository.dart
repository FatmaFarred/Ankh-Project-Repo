import '../../entities/product_post_entity.dart';

abstract class PostProductRepository {
  Future<void> postProduct(ProductPostEntity entity);
  Future<void> editProduct(int id, ProductPostEntity entity);

}
