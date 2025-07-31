// lib/domain/use_cases/get_product_management_details_usecase.dart

import 'package:injectable/injectable.dart';
import '../entities/product_management_details_entity.dart';
import '../repositries_and_data_sources/repositries/product_management_repository.dart';

@lazySingleton
class GetProductManagementDetailsUseCase {
  final ProductManagementRepository repository;

  GetProductManagementDetailsUseCase(this.repository);

  Future<ProductManagementDetailsEntity> call(int id) {
    return repository.getProductDetails(id);
  }
}
