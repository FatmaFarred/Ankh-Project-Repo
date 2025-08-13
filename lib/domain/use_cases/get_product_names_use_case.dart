import 'package:ankh_project/domain/entities/product_name_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_name_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductNamesUseCase {
  final ProductNameRepository repository;

  GetProductNamesUseCase(this.repository);

  Future<List<ProductNameEntity>> call() async {
    return await repository.getAllProductNames();
  }
}