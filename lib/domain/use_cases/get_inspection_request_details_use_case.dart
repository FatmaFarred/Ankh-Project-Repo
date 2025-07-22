import 'package:injectable/injectable.dart';
import '../entities/inspection_request_details_entity.dart';
import '../repositries_and_data_sources/repositries/inspection_request_details_repository.dart';

@lazySingleton
class GetInspectionRequestDetailsUseCase {
  final InspectionRequestDetailsRepository repository;

  GetInspectionRequestDetailsUseCase(this.repository);

  Future<InspectionRequestDetailsEntity> call({
    required String token,
    required int requestId,
  }) {
    return repository.getRequestDetails(
      token: token,
      requestId: requestId,
    );
  }
}
