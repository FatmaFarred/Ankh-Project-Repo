import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../api_service/failure/error_handling.dart';

abstract class MarketerAssignProductState {}

class MarketerAssignProductInitial extends MarketerAssignProductState {}

class MarketerAssignProductLoading extends MarketerAssignProductState {}

class MarketerAssignProductSuccess extends MarketerAssignProductState {
  final String? message;
  MarketerAssignProductSuccess({ required this.message});
}


class MarketerAssignProductError extends MarketerAssignProductState {
  Failure error;
  MarketerAssignProductError({ required this.error});
}
