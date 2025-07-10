import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_products_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_products_repositry.dart';

@Injectable(as: MarketerProductsRepositry)
 class MarketerProductsRepositryImpl implements MarketerProductsRepositry{
  MarketerProductsRemoteDataSource marketerProductsRemoteDataSource;
  MarketerProductsRepositryImpl(this.marketerProductsRemoteDataSource);
  Future <Either<Failure,List<AllProductsEntity>>>getAllMarketerProducts ( String userId )async{
    var either =await marketerProductsRemoteDataSource.getAllMarketerProducts(userId);
    return either.fold((error) => left(error), (response) => right(response));


  }

}