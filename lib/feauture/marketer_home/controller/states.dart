import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../api_service/failure/error_handling.dart';

abstract class MarketerHomeProductState {}

class MarketerHomeProductInitial extends MarketerHomeProductState {}

class MarketerHomeProductLoading extends MarketerHomeProductState {}

class MarketerHomeProductSuccess extends MarketerHomeProductState {
  final List<AllProductsEntity> productList;
  MarketerHomeProductSuccess({ required this.productList});
}

class MarketerHomeProductEmpty extends MarketerHomeProductState {}

class MarketerHomeProductError extends MarketerHomeProductState {
  Failure error;
  MarketerHomeProductError({ required this.error});
}
