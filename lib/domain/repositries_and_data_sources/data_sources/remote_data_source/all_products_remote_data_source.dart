

import '../../../../data/models/all_products_dm.dart';

abstract class AllProductsRemoteDataSource {
  Future<List<AllProductsDm>> getAllProducts();
}
