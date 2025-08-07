import 'dart:io';
import 'package:ankh_project/domain/entities/top_brand_entity.dart';

abstract class TopBrandRepository {
  Future<List<TopBrandEntity>> getTopBrands();
  Future<bool> addTopBrand({required String name, required File imageFile});
  Future<bool> editTopBrand({required int id, required String name, required File? imageFile});
  Future<bool> deleteTopBrand({required int id});
}
