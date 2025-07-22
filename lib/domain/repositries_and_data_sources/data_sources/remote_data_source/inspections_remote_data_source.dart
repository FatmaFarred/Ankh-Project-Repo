import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/all_inpection_entity.dart';


abstract class MyInspectionsRemoteDataSource {
  Future<Either<Failure,List<AllInpectionEntity>>> getMyInspections({
    required String token,
    required String filter,
  });
} 