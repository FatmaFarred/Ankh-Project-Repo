import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/top_brand_repository.dart';

@lazySingleton
class DeleteTopBrandUseCase {
  final TopBrandRepository repository;

  DeleteTopBrandUseCase(this.repository);

  Future<bool> call({required int id}) async {
    return await repository.deleteTopBrand(id: id);
  }
}