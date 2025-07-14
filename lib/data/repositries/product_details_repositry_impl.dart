import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/repositries/product_details_repositry.dart';

@Injectable(as: ProductDetailsRepositry)
 class ProductDetailsRepositryImpl implements ProductDetailsRepositry {
  ProductDetailsRemoteDataSource productDetailsRemoteDataSource;
  ProductDetailsRepositryImpl(this.productDetailsRemoteDataSource);

  Future <Either<Failure,AllProductsEntity>>getProductDetails ( num productId  )async{
    var either =await productDetailsRemoteDataSource.getProductDetails(productId);
    return either.fold((error) => left(error), (response) => right(response));



  }

}