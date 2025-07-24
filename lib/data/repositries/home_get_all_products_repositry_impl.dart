
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/home_get_all_products_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/home_get_all_products_repositry.dart';

@Injectable(as: HomeGetAllProductsRepositry)
 class HomeGetAllProductsRepositryImpl implements HomeGetAllProductsRepositry {

   HomeGetAllProductsRemoteDataSource homeGetAllProductsRemoteDataSource;

    HomeGetAllProductsRepositryImpl(this.homeGetAllProductsRemoteDataSource);


  Future <Either<Failure,List<AllProductsEntity>>>getHomeAllProducts ()async{
    var either =await homeGetAllProductsRemoteDataSource.getHomeAllProducts();
    return either.fold((error) => left(error), (response) => right(response));

  }

  Future <Either<Failure,List<AllProductsEntity>>>searchAllProducts (String keyWord)async{
    var either =await homeGetAllProductsRemoteDataSource.searchAllProducts(keyWord);
    return either.fold((error) => left(error), (response) => right(response));

  }

}