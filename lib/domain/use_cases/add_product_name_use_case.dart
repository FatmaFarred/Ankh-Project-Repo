import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_name_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductNameUseCase {
  final ProductNameRepository repository;

  AddProductNameUseCase(this.repository);

  Future<void> call(String name) async {
    await repository.addProductName(name);
  }
}