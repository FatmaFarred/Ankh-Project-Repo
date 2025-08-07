import 'dart:io';
import 'package:injectable/injectable.dart';

import '../entities/top_brand_entity.dart';
import '../repositries_and_data_sources/repositries/top_brand_repository.dart';

@lazySingleton
class AddTopBrandUseCase {
  final TopBrandRepository repository;

  AddTopBrandUseCase(this.repository);

  Future<bool> call({required String name, required File imageFile}) async {
    return await repository.addTopBrand(name: name, imageFile: imageFile);
  }
}