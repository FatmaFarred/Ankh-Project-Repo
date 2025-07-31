  // lib/domain/use_cases/get_all_products_usecase.dart

  import '../entities/product_management_entity.dart';
  import 'package:injectable/injectable.dart';
  import '../repositries_and_data_sources/repositries/product_management_repository.dart';

  @injectable
  class GetAllProductsUseCase {
    final ProductManagementRepository repository;

    GetAllProductsUseCase(this.repository);

    Future<List<ProductManagementEntity>> call() {
      return repository.getAllProducts();
    }
  }
