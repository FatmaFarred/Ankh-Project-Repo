import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/failure/error_handling.dart';
import '../entities/all_inpection_entity.dart';
import '../repositries_and_data_sources/repositries/inspections_repository.dart';
import '../repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';
@injectable
class RescheduleInspectionUseCase {
  HomeGetAllInspectionRepositry repository;

  RescheduleInspectionUseCase( this.repository);

  Future<Either<Failure, String?>> execute(String date,String time,String adminNote,num inspectionId) async {
    return  repository.rescheduleInspection(date, time, adminNote, inspectionId);
  }
}