import 'dart:io';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/top_brand_repository.dart';

@lazySingleton
class EditTopBrandUseCase {
  final TopBrandRepository repository;

  EditTopBrandUseCase(this.repository);

  Future<bool> call({required int id, required String name, required File? imageFile}) async {
    return await repository.editTopBrand(id: id, name: name, imageFile: imageFile);
  }
}