import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

abstract class InspectorHomeProductState {}

class InspectorHomeProductInitial extends InspectorHomeProductState {}

class InspectorHomeProductLoading extends InspectorHomeProductState {}

class InspectorHomeProductSuccess extends InspectorHomeProductState {
  final List<AllInpectionEntity> productList;
  InspectorHomeProductSuccess({ required this.productList});
}

class InspectorHomeProductEmpty extends InspectorHomeProductState {}

class InspectorHomeProductError extends InspectorHomeProductState {
  Failure error;
  InspectorHomeProductError({ required this.error});
}
