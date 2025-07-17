  import 'package:ankh_project/data/models/all_prosucts_dm.dart';


abstract class AllProductsRemoteDataSource {
  Future<List<AllProductsDm>> getAllProducts();
}
