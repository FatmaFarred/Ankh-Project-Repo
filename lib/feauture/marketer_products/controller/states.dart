import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../api_service/failure/error_handling.dart';

abstract class MarketerProductState {}

class MarketerProductInitial extends MarketerProductState {}

class MarketerProductLoading extends MarketerProductState {}

class MarketerProductSuccess extends MarketerProductState {
  final List<AllProductsEntity> requestList;
  MarketerProductSuccess({ required this.requestList});
}

class MarketerProductEmpty extends MarketerProductState {}

class MarketerProductError extends MarketerProductState {
  Failure error;
  MarketerProductError({ required this.error});
}
