import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/failure/error_handling.dart';
import '../entities/all_inpection_entity.dart';
import '../repositries_and_data_sources/repositries/inspections_repository.dart';
@injectable
class GetAllInspectionByIdUseCase{
  MyInspectionsRepository repository;

  GetAllInspectionByIdUseCase( this.repository);

  Future<Either<Failure, List<AllInpectionEntity>>> execute({required String inspectorId})  {
    return  repository.getAllOfMyInspections(inspectorId);
  }
}