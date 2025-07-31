import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';

@injectable
class GetInspectorInspectionsUseCase {
  final HomeGetAllInspectionRepositry repository;

  GetInspectorInspectionsUseCase(this.repository);

  Future<Either<Failure, List<AllInpectionEntity>>> execute(String inspectorId) {
    return repository.getInspectionsByInspectorId(inspectorId);
  }
} 