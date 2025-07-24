import 'package:dartz/dartz.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../entities/all_inpection_entity.dart';
import '../../entities/inspection_report_details_entity.dart';

abstract class MyInspectionsRepository {
  Future<Either<Failure,List<AllInpectionEntity>>> getMyInspections({
    required String token,
    required String filter,
  });

  Future<Either<Failure, InspectionReportDetailsEntity>> getReportDetails({
    required num requestId,
  });
} 