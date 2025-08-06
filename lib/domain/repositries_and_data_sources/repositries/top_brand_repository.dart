import 'package:ankh_project/domain/entities/top_brand_entity.dart';

abstract class TopBrandRepository {
  Future<List<TopBrandEntity>> getTopBrands();
}
