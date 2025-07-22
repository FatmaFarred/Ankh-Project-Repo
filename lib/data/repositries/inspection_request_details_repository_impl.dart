import 'package:ankh_project/domain/repositries_and_data_sources/repositries/inspection_request_details_repository.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/inspection_request_details_entity.dart';
import '../data_sources/inspection_request_details_remote_data_source.dart';

@LazySingleton(as: InspectionRequestDetailsRepository)
class InspectionRequestDetailsRepositoryImpl
    implements InspectionRequestDetailsRepository {
  final InspectionRequestDetailsRemoteDataSource remoteDataSource;

  InspectionRequestDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<InspectionRequestDetailsEntity> getRequestDetails({
    required String token,
    required int requestId,
  }) {
    return remoteDataSource.getRequestDetails(
      token: token,
      requestId: requestId,
    );
  }
}
