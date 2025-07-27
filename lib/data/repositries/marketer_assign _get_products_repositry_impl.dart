import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/entities/all_products_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_assign _get_products_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';

@Injectable(as: MarketerAssignGetProductsRepositry)
 class MarketerAssignGetProductsRepositryImpl implements MarketerAssignGetProductsRepositry{

  MarketerAssignGetProductsRemoteDataSource marketerProductsRemoteDataSource;

  MarketerAssignGetProductsRepositryImpl(this.marketerProductsRemoteDataSource);

  Future <Either<Failure,List<AllProductsEntity>>>getMarketerProducts ( String userId )async{
    var either =await marketerProductsRemoteDataSource.getMarketerProducts(userId);
    return either.fold((error) => left(error), (response) => right(response));


  }

  Future <Either<Failure,String?>>assignProduct ( num productId, String userId )async{
    var either =await marketerProductsRemoteDataSource.assignProduct(productId, userId);
    return either.fold((error) => left(error), (response) => right(response));


  }

  @override
  Future<Either<Failure, List<AllMarketersEntity>>> getAllMarketers()async {
    var either =await marketerProductsRemoteDataSource.getAllMarketers();
    return either.fold((error) => left(error), (response) => right(response));
  }



  @override
  Future<Either<Failure, String?>> updateMarketerAccountStatus(num status, String userId) async{
    var either =await marketerProductsRemoteDataSource.updateMarketerAccountStatus(status, userId);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, List<AllMarketersEntity>>> searchMarketer(String keyWord)async {
    var either =await marketerProductsRemoteDataSource.searchMarketer(keyWord);
    return either.fold((error) => left(error), (response) => right(response));
  }





}