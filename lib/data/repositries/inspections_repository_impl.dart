import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/all_inpection_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspections_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/inspections_repository.dart';
import '../../api_service/failure/error_handling.dart';
import '../data_sources/inspections_remote_data_source_impl.dart';
@Injectable(as: MyInspectionsRepository)
class MyInspectionsRepositoryImpl implements MyInspectionsRepository {
  MyInspectionsRemoteDataSource remoteDataSource;

  MyInspectionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AllInpectionEntity>>> getMyInspections({
    required String token,
    required String filter,
  }) async {
    var either= await remoteDataSource.getMyInspections(token: token, filter: filter);
    return either.fold(
      (error) => left(error),
      (response) => right(response),
    );
  }
} 