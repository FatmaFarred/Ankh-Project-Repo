import 'package:dartz/dartz.dart';
import '../entities/inspection_report_details_entity.dart';
import '../repositries_and_data_sources/repositries/inspections_repository.dart';
import '../../api_service/failure/error_handling.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetReportDetailsUseCase {
  final MyInspectionsRepository repository;
  GetReportDetailsUseCase(this.repository);

  Future<Either<Failure, InspectionReportDetailsEntity>> execute({required num requestId}) {
    return repository.getReportDetails(requestId: requestId);
  }
} 