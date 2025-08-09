import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/failure/error_handling.dart';
import '../entities/all_inpection_entity.dart';
import '../repositries_and_data_sources/repositries/inspections_repository.dart';
import '../repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';
@injectable
class SearchInspectionAdminUseCase {
  HomeGetAllInspectionRepositry repository;

  SearchInspectionAdminUseCase( this.repository);

  Future<Either<Failure, List<AllInpectionEntity>>> execute(String keyWord) async {
    return  repository.searchAllInspectionAdmin(keyWord);
  }
}