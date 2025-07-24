import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_add_request_inspection%20_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../data/models/add_inspection _request.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_add_request_inspection.dart';

@Injectable(as: MarketerAddRequestInspectionRepositry)
 class MarketerAddRequestInspectionRepositryImpl implements MarketerAddRequestInspectionRepositry {

   MarketerAddRequestInspectionRemoteDataSource marketerAddRequestInspectionRemoteDataSource;
  MarketerAddRequestInspectionRepositryImpl({required this.marketerAddRequestInspectionRemoteDataSource});
  Future <Either<Failure,String?>>addRequest (InspectionRequest request  )async{
    var either= await marketerAddRequestInspectionRemoteDataSource.addRequest(request);
    return either.fold((error) => left(error), (response) => right(response));

  }

}