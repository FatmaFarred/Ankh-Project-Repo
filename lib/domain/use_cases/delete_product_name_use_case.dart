import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_name_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductNameUseCase {
  final ProductNameRepository repository;

  DeleteProductNameUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteProductName(id);
  }
}