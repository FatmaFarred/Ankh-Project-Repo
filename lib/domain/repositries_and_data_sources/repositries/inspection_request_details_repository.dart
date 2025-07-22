import '../../entities/inspection_request_details_entity.dart';

abstract class InspectionRequestDetailsRepository {
  Future<InspectionRequestDetailsEntity> getRequestDetails({
    required String token,
    required int requestId,
  });
}
