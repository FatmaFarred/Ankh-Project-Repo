import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';
@injectable

class GetAllMarketersUseCase{
  MarketerAssignGetProductsRepositry marketerAssignGetProductsRepositry;
  GetAllMarketersUseCase(this.marketerAssignGetProductsRepositry);

  Future <Either<Failure,List<AllMarketersEntity>>>execute ()async{
    return await marketerAssignGetProductsRepositry.getAllMarketers();

  }


}