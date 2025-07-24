import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_request_inspection_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

abstract class ProductDetailsStates{}

class ProductDetailsInitial extends ProductDetailsStates {}

class ProductDetailsLoading extends ProductDetailsStates {}

class ProductDetailsSuccess extends ProductDetailsStates {
  final ProductDetailsEntity productDetails;
  ProductDetailsSuccess({ required this.productDetails});
}


class ProductDetailsError extends ProductDetailsStates {
  Failure error;
  ProductDetailsError({ required this.error});
}
