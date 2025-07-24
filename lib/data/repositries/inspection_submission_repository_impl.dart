import 'package:injectable/injectable.dart';
import '../../../data/data_sources/inspection_submission_remote_data_source.dart';
import '../../../domain/entities/inspection_submission_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/inspection_submission_repository.dart';
import '../models/inspection_submission_model.dart';

@LazySingleton(as: InspectionSubmissionRepository)
class InspectionSubmissionRepositoryImpl
    implements InspectionSubmissionRepository {
  final InspectionSubmissionRemoteDataSource remoteDataSource;

  InspectionSubmissionRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitInspection(InspectionSubmissionEntity entity) {
    final model = InspectionSubmissionModel(
      requestInspectionId: entity.requestInspectionId,
      status: entity.status,
      inspectorComment: entity.inspectorComment,
      images: entity.images,
    );
    return remoteDataSource.submitReport(model);
  }
}