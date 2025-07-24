import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class InspectorAssignProductState {}

class InspectorAssignProductInitial extends InspectorAssignProductState {}

class InspectorAssignProductLoading extends InspectorAssignProductState {}

class InspectorAssignProductSuccess extends InspectorAssignProductState {
  final String? message;
  InspectorAssignProductSuccess({ required this.message});
}


class InspectorAssignProductError extends InspectorAssignProductState {
  Failure error;
  InspectorAssignProductError({ required this.error});
}
