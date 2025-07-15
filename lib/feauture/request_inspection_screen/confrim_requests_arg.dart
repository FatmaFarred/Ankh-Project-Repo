import 'package:ankh_project/domain/entities/all_products_entity.dart';

import '../../data/models/add_inspection _request.dart';

class ConfirmRequestArgs {
  final AllProductsEntity product;
  final InspectionRequest request;

  ConfirmRequestArgs({required this.product, required this.request});
}