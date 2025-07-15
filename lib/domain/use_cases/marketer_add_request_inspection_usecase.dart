import 'package:ankh_project/data/models/add_inspection%20_request.dart';
import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/all_products_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/marketer_add_request_inspection.dart';
@injectable
class MarketerAddRequestInspectionUseCase {
  MarketerAddRequestInspectionRepositry repository;

  MarketerAddRequestInspectionUseCase(this.repository);

  Future<Either<Failure, String?>> addRequest(InspectionRequest request)  {
    return repository.addRequest(request);
  }
}