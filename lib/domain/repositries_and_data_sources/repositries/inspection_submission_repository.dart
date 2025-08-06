import 'package:dartz/dartz.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/inspection_submission_entity.dart';

abstract class InspectionSubmissionRepository {
  Future <Either<Failure,String?>>submitInspection(InspectionSubmissionEntity entity);
}