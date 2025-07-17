import 'package:ankh_project/domain/entities/product_details_entity.dart';

import '../../data/models/add_inspection _request.dart';

class ConfirmRequestArgs {
  final ProductDetailsEntity product;
  final InspectionRequest request;

  ConfirmRequestArgs({required this.product, required this.request});
}